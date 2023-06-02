Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA9C71FB79
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjFBIAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjFBIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:00:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E9123
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:00:28 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QXb5S526NzSmVf;
        Fri,  2 Jun 2023 16:00:12 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 16:00:25 +0800
Content-Type: multipart/mixed;
        boundary="------------R97iEtUas9IWQfHyjpjaSHmQ"
Message-ID: <1c944c86-71d1-bece-f4d5-3ec2f6d262a9@huawei.com>
Date:   Fri, 2 Jun 2023 16:00:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
CC:     <mawupeng1@huawei.com>, <akpm@linux-foundation.org>,
        <kirill.shutemov@linux.intel.com>, <n-horiguchi@ah.jp.nec.com>,
        <jmarchan@redhat.com>, <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC PATCH stable 5.10/5.15] mm: Pass head page to
 clear_page_mlock for page_remove_rmap
To:     <hughd@google.com>
References: <20230529123705.955378-1-mawupeng1@huawei.com>
 <25befa-bef0-467a-3e7-e331131d011@google.com>
Content-Language: en-US
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <25befa-bef0-467a-3e7-e331131d011@google.com>
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------R97iEtUas9IWQfHyjpjaSHmQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



On 2023/6/2 10:04, Hugh Dickins wrote:
> On Mon, 29 May 2023, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> Our syzbot report a mlock related problem. During exit_mm, tail page is
>> passed to clear_page_mlock which final lead to kernel panic.
>>
>> During unmap_page_range, if compound is false, it means this page is
>> seen as a small page. This page is passed to isolate_lru_page if this
>> page is PageMlocked and finally lead to "trying to isolate tail page"
>> warning.
>>
>> Here is the simplified calltrace:
>>
>> unmap_page_range
>>   zap_pte_range
>>     page_remove_rmap(page, false);	// compound is false means to handle
>> 					   to small page not compound page
>> 	  nr_pages = thp_nr_pages(page);
>> 	  clear_page_mlock(page)	// maybe tail page here
>> 		isolate_lru_page
>> 		  WARN_RATELIMIT(PageTail(page), "trying to isolate tail page");
>>
>> Since mlock is not supposed to handle tail, we pass head page to
>> clear_page_mlock() to slove this problem.
> 
> Your patch looks plausible for stable, and might even end up as the best
> that can be done; but I think you have not root-caused the problem yet
> (and until it's root-caused, there is likely to be other damage).

This I do agreed. The root cause of this problem is still unknown.

> 
> 5.15 and 5.10 were releases with the PageDoubleMap flag, and the intention
> then was that a compound page with PageDoubleMap set could not be Mlocked,
> and PageMlocked had to be cleared when setting PageDoubleMap.
> 
> See, for example, the line in the old mlock_vma_page()
> 	VM_BUG_ON_PAGE(PageCompound(page) && PageDoubleMap(page), page);
> before it did the TestSetPageMlocked().
> 
> So it should have been impossible to find PageMlocked on a Tail page
> (even with PageMlocked redirecting to the head page to look up the flag)
> there; so unnecessary for clear_page_mlock() to use compound_head().
> 
> Since nobody reported this problem before, my suspicion is that a commit
> has been backported to 5.15 and 5.10 stable, which does not belong there.
> Or perhaps the stable trees are okay, but your own tree has an unsuitable
> backport in it?

We are using the latest 5.10/5.15 for testing, without any our own patches.
The corresponding reproduction c file is attached as follow.

We are tesing it in ARM64 with the following config enabled:

CONFIG_KASAN=y
CONFIG_DEBUG_VM=y
CONFIG_DEBUG_LIST=y

> 
>>
>> This bug can lead to multiple reports. Here ares the simplified reports:
>>
>> ------------[ cut here ]------------
>> trying to isolate tail page
>> WARNING: CPU: 1 PID: 24489 at mm/vmscan.c:2031 isolate_lru_page+0x574/0x660
>>
>> page:fffffc000eb7a300 refcount:512 mapcount:0 mapping:0000000000000000 index:0x2008c pfn:0x3ede8c
>> head:fffffc000eb78000 order:9 compound_mapcount:0 compound_pincount:0
>> memcg:ffff0000d24bc000
>> anon flags: 0x37ffff80009080c(uptodate|dirty|arch_1|head|swapbacked|node=1|zone=2|lastcpupid=0xfffff)
>> raw: 037ffff800000800 fffffc000eb78001 fffffc000eb7a308 dead000000000400
>> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>> head: 037ffff80009080c fffffc000eb70008 fffffc000e350708 ffff0003829eb839
>> head: 0000000000020000 0000000000000000 00000200ffffffff ffff0000d24bc000
>> page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled())
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 24489 at include/linux/memcontrol.h:767 lock_page_lruvec_irq+0x148/0x190
>>
>> page:fffffc000eb7a300 refcount:0 mapcount:0 mapping:dead000000000400 index:0x0 pfn:0x3ede8c
>> failed to read mapping contents, not a valid kernel address?
>> flags: 0x37ffff800000800(arch_1|node=1|zone=2|lastcpupid=0xfffff)
>> raw: 037ffff800000800 dead000000000100 dead000000000122 dead000000000400
>> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
>> page dumped because: VM_BUG_ON_PAGE(((unsigned int) page_ref_count(page) + 127u <= 127u))
>> ------------[ cut here ]------------
>> kernel BUG at include/linux/mm.h:1213!
>> Call trace:
>>  lru_cache_add+0x2d4/0x2e8
>>  putback_lru_page+0x2c/0x168
>>  clear_page_mlock+0x254/0x318
>>  page_remove_rmap+0x900/0x9c0
>>  unmap_page_range+0xa78/0x16a0
>>  unmap_single_vma+0x114/0x1a0
>>  unmap_vmas+0x100/0x220
>>  exit_mmap+0x120/0x410
>>  mmput+0x174/0x498
>>  exit_mm+0x33c/0x460
>>  do_exit+0x3c0/0x1310
>>  do_group_exit+0x98/0x170
>>  get_signal+0x370/0x13d0
>>  do_notify_resume+0x5a0/0x968
>>  el0_da+0x154/0x188
>>  el0t_64_sync_handler+0x88/0xb8
>>  el0t_64_sync+0x1a0/0x1a4
>> Code: 912b0021 aa1503e0 910c0021 9401a49c (d4210000)
>>
>> This bug can be reproduced in both linux-5.10.y & linux-5.15.y and maybe
>> fixed after commit 889a3747b3b7 ("mm/lru: Add folio LRU functions").
>> This patch turn page into folio for LRU related operations, all
>> operations to page is turn to folio which means head page after this
>> patch.
> 
> No, that commit is not likely to have been a fix for this issue.
> If there ever was such an issue in the 5.15 and 5.10 trees, it would
> more likely have been fixed by the munlock changes in 5.18, or by the
> removal of PageDoubleMap in 6.2.

Sorry, my bad, commit 889a3747b3b7 ("mm/lru: Add folio LRU functions")
only fix one warning, the real fix is commit b109b87050df, ("mm/munlock:
replace clear_page_mlock() by final clearance").

> 
>>
>> Fixes: d281ee614518 ("rmap: add argument to charge compound page")
> 
> Perhaps, but I think an inappropriate backport is more likely.
> 
>> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
>> ---
>>  mm/rmap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 330b361a460e..8838f6a9d65d 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1372,7 +1372,7 @@ void page_remove_rmap(struct page *page, bool compound)
>>  	__dec_lruvec_page_state(page, NR_ANON_MAPPED);
>>  
>>  	if (unlikely(PageMlocked(page)))
>> -		clear_page_mlock(page);
>> +		clear_page_mlock(compound_head(page));
>>  
>>  	if (PageTransCompound(page))
>>  		deferred_split_huge_page(compound_head(page));
> 
> And what about the clear_page_mlock() in page_remove_file_rmap()?

According to the same logic, this should be fixed too.

Thanks for your reply,
Wupeng

> 
> Thanks,
> Hugh
--------------R97iEtUas9IWQfHyjpjaSHmQ
Content-Type: text/plain; charset="UTF-8"; name="isolate_lru_page.c"
Content-Disposition: attachment; filename="isolate_lru_page.c"
Content-Transfer-Encoding: base64

Ly8gYXV0b2dlbmVyYXRlZCBieSBzeXprYWxsZXIgKGh0dHBzOi8vZ2l0aHViLmNvbS9nb29n
bGUvc3l6a2FsbGVyKQoKI2RlZmluZSBfR05VX1NPVVJDRQoKI2luY2x1ZGUgPGRpcmVudC5o
PgojaW5jbHVkZSA8ZW5kaWFuLmg+CiNpbmNsdWRlIDxlcnJuby5oPgojaW5jbHVkZSA8ZmNu
dGwuaD4KI2luY2x1ZGUgPHNjaGVkLmg+CiNpbmNsdWRlIDxzZXRqbXAuaD4KI2luY2x1ZGUg
PHNpZ25hbC5oPgojaW5jbHVkZSA8c3RkYXJnLmg+CiNpbmNsdWRlIDxzdGRib29sLmg+CiNp
bmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIu
aD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL3ByY3RsLmg+CiNpbmNsdWRl
IDxzeXMvc3RhdC5oPgojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KI2luY2x1ZGUgPHN5cy90
eXBlcy5oPgojaW5jbHVkZSA8c3lzL3dhaXQuaD4KI2luY2x1ZGUgPHRpbWUuaD4KI2luY2x1
ZGUgPHVuaXN0ZC5oPgoKI2lmbmRlZiBfX05SX2Nsb25lCiNkZWZpbmUgX19OUl9jbG9uZSAy
MjAKI2VuZGlmCiNpZm5kZWYgX19OUl9leGl0CiNkZWZpbmUgX19OUl9leGl0IDkzCiNlbmRp
ZgojaWZuZGVmIF9fTlJfbWJpbmQKI2RlZmluZSBfX05SX21iaW5kIDIzNQojZW5kaWYKI2lm
bmRlZiBfX05SX21sb2NrYWxsCiNkZWZpbmUgX19OUl9tbG9ja2FsbCAyMzAKI2VuZGlmCiNp
Zm5kZWYgX19OUl9tbWFwCiNkZWZpbmUgX19OUl9tbWFwIDIyMgojZW5kaWYKI2lmbmRlZiBf
X05SX3NobWF0CiNkZWZpbmUgX19OUl9zaG1hdCAxOTYKI2VuZGlmCiNpZm5kZWYgX19OUl9z
aG1nZXQKI2RlZmluZSBfX05SX3NobWdldCAxOTQKI2VuZGlmCgpzdGF0aWMgX190aHJlYWQg
aW50IGNsb25lX29uZ29pbmc7CnN0YXRpYyBfX3RocmVhZCBpbnQgc2tpcF9zZWd2OwpzdGF0
aWMgX190aHJlYWQgam1wX2J1ZiBzZWd2X2VudjsKCnN0YXRpYyB2b2lkIHNlZ3ZfaGFuZGxl
cihpbnQgc2lnLCBzaWdpbmZvX3QqIGluZm8sIHZvaWQqIGN0eCkKewogIGlmIChfX2F0b21p
Y19sb2FkX24oJmNsb25lX29uZ29pbmcsIF9fQVRPTUlDX1JFTEFYRUQpICE9IDApIHsKICAg
IGV4aXQoc2lnKTsKICB9CiAgdWludHB0cl90IGFkZHIgPSAodWludHB0cl90KWluZm8tPnNp
X2FkZHI7CiAgY29uc3QgdWludHB0cl90IHByb2dfc3RhcnQgPSAxIDw8IDIwOwogIGNvbnN0
IHVpbnRwdHJfdCBwcm9nX2VuZCA9IDEwMCA8PCAyMDsKICBpbnQgc2tpcCA9IF9fYXRvbWlj
X2xvYWRfbigmc2tpcF9zZWd2LCBfX0FUT01JQ19SRUxBWEVEKSAhPSAwOwogIGludCB2YWxp
ZCA9IGFkZHIgPCBwcm9nX3N0YXJ0IHx8IGFkZHIgPiBwcm9nX2VuZDsKICBpZiAoc2tpcCAm
JiB2YWxpZCkgewogICAgX2xvbmdqbXAoc2Vndl9lbnYsIDEpOwogIH0KICBleGl0KHNpZyk7
Cn0KCnN0YXRpYyB2b2lkIGluc3RhbGxfc2Vndl9oYW5kbGVyKHZvaWQpCnsKICBzdHJ1Y3Qg
c2lnYWN0aW9uIHNhOwogIG1lbXNldCgmc2EsIDAsIHNpemVvZihzYSkpOwogIHNhLnNhX2hh
bmRsZXIgPSBTSUdfSUdOOwogIHN5c2NhbGwoU1lTX3J0X3NpZ2FjdGlvbiwgMHgyMCwgJnNh
LCBOVUxMLCA4KTsKICBzeXNjYWxsKFNZU19ydF9zaWdhY3Rpb24sIDB4MjEsICZzYSwgTlVM
TCwgOCk7CiAgbWVtc2V0KCZzYSwgMCwgc2l6ZW9mKHNhKSk7CiAgc2Euc2Ffc2lnYWN0aW9u
ID0gc2Vndl9oYW5kbGVyOwogIHNhLnNhX2ZsYWdzID0gU0FfTk9ERUZFUiB8IFNBX1NJR0lO
Rk87CiAgc2lnYWN0aW9uKFNJR1NFR1YsICZzYSwgTlVMTCk7CiAgc2lnYWN0aW9uKFNJR0JV
UywgJnNhLCBOVUxMKTsKfQoKI2RlZmluZSBOT05GQUlMSU5HKC4uLikgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAoeyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKICAgIGludCBvayA9IDE7ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgIF9fYXRv
bWljX2ZldGNoX2FkZCgmc2tpcF9zZWd2LCAxLCBfX0FUT01JQ19TRVFfQ1NUKTsgICAgICAg
ICAgICAgICAgICAgICAgIFwKICAgIGlmIChfc2V0am1wKHNlZ3ZfZW52KSA9PSAwKSB7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgX19W
QV9BUkdTX187ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKICAgIH0gZWxzZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKICAgICAgb2sg
PSAwOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKICAgIF9fYXRvbWljX2ZldGNoX3N1Yigmc2tpcF9zZWd2LCAx
LCBfX0FUT01JQ19TRVFfQ1NUKTsgICAgICAgICAgICAgICAgICAgICAgIFwKICAgIG9rOyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKICB9KQoKc3RhdGljIHZvaWQgc2xlZXBfbXModWludDY0X3Qg
bXMpCnsKICB1c2xlZXAobXMgKiAxMDAwKTsKfQoKc3RhdGljIHVpbnQ2NF90IGN1cnJlbnRf
dGltZV9tcyh2b2lkKQp7CiAgc3RydWN0IHRpbWVzcGVjIHRzOwogIGlmIChjbG9ja19nZXR0
aW1lKENMT0NLX01PTk9UT05JQywgJnRzKSkKICAgIGV4aXQoMSk7CiAgcmV0dXJuICh1aW50
NjRfdCl0cy50dl9zZWMgKiAxMDAwICsgKHVpbnQ2NF90KXRzLnR2X25zZWMgLyAxMDAwMDAw
Owp9CgpzdGF0aWMgYm9vbCB3cml0ZV9maWxlKGNvbnN0IGNoYXIqIGZpbGUsIGNvbnN0IGNo
YXIqIHdoYXQsIC4uLikKewogIGNoYXIgYnVmWzEwMjRdOwogIHZhX2xpc3QgYXJnczsKICB2
YV9zdGFydChhcmdzLCB3aGF0KTsKICB2c25wcmludGYoYnVmLCBzaXplb2YoYnVmKSwgd2hh
dCwgYXJncyk7CiAgdmFfZW5kKGFyZ3MpOwogIGJ1ZltzaXplb2YoYnVmKSAtIDFdID0gMDsK
ICBpbnQgbGVuID0gc3RybGVuKGJ1Zik7CiAgaW50IGZkID0gb3BlbihmaWxlLCBPX1dST05M
WSB8IE9fQ0xPRVhFQyk7CiAgaWYgKGZkID09IC0xKQogICAgcmV0dXJuIGZhbHNlOwogIGlm
ICh3cml0ZShmZCwgYnVmLCBsZW4pICE9IGxlbikgewogICAgaW50IGVyciA9IGVycm5vOwog
ICAgY2xvc2UoZmQpOwogICAgZXJybm8gPSBlcnI7CiAgICByZXR1cm4gZmFsc2U7CiAgfQog
IGNsb3NlKGZkKTsKICByZXR1cm4gdHJ1ZTsKfQoKc3RhdGljIHZvaWQga2lsbF9hbmRfd2Fp
dChpbnQgcGlkLCBpbnQqIHN0YXR1cykKewogIGtpbGwoLXBpZCwgU0lHS0lMTCk7CiAga2ls
bChwaWQsIFNJR0tJTEwpOwogIGZvciAoaW50IGkgPSAwOyBpIDwgMTAwOyBpKyspIHsKICAg
IGlmICh3YWl0cGlkKC0xLCBzdGF0dXMsIFdOT0hBTkcgfCBfX1dBTEwpID09IHBpZCkKICAg
ICAgcmV0dXJuOwogICAgdXNsZWVwKDEwMDApOwogIH0KICBESVIqIGRpciA9IG9wZW5kaXIo
Ii9zeXMvZnMvZnVzZS9jb25uZWN0aW9ucyIpOwogIGlmIChkaXIpIHsKICAgIGZvciAoOzsp
IHsKICAgICAgc3RydWN0IGRpcmVudCogZW50ID0gcmVhZGRpcihkaXIpOwogICAgICBpZiAo
IWVudCkKICAgICAgICBicmVhazsKICAgICAgaWYgKHN0cmNtcChlbnQtPmRfbmFtZSwgIi4i
KSA9PSAwIHx8IHN0cmNtcChlbnQtPmRfbmFtZSwgIi4uIikgPT0gMCkKICAgICAgICBjb250
aW51ZTsKICAgICAgY2hhciBhYm9ydFszMDBdOwogICAgICBzbnByaW50ZihhYm9ydCwgc2l6
ZW9mKGFib3J0KSwgIi9zeXMvZnMvZnVzZS9jb25uZWN0aW9ucy8lcy9hYm9ydCIsCiAgICAg
ICAgICAgICAgIGVudC0+ZF9uYW1lKTsKICAgICAgaW50IGZkID0gb3BlbihhYm9ydCwgT19X
Uk9OTFkpOwogICAgICBpZiAoZmQgPT0gLTEpIHsKICAgICAgICBjb250aW51ZTsKICAgICAg
fQogICAgICBpZiAod3JpdGUoZmQsIGFib3J0LCAxKSA8IDApIHsKICAgICAgfQogICAgICBj
bG9zZShmZCk7CiAgICB9CiAgICBjbG9zZWRpcihkaXIpOwogIH0gZWxzZSB7CiAgfQogIHdo
aWxlICh3YWl0cGlkKC0xLCBzdGF0dXMsIF9fV0FMTCkgIT0gcGlkKSB7CiAgfQp9CgpzdGF0
aWMgdm9pZCBzZXR1cF90ZXN0KCkKewogIHByY3RsKFBSX1NFVF9QREVBVEhTSUcsIFNJR0tJ
TEwsIDAsIDAsIDApOwogIHNldHBncnAoKTsKICB3cml0ZV9maWxlKCIvcHJvYy9zZWxmL29v
bV9zY29yZV9hZGoiLCAiMTAwMCIpOwp9CgojZGVmaW5lIFVTTEVFUF9GT1JLRURfQ0hJTEQg
KDMgKiA1MCAqIDEwMDApCgpzdGF0aWMgbG9uZyBoYW5kbGVfY2xvbmVfcmV0KGxvbmcgcmV0
KQp7CiAgaWYgKHJldCAhPSAwKSB7CiAgICBfX2F0b21pY19zdG9yZV9uKCZjbG9uZV9vbmdv
aW5nLCAwLCBfX0FUT01JQ19SRUxBWEVEKTsKICAgIHJldHVybiByZXQ7CiAgfQogIHVzbGVl
cChVU0xFRVBfRk9SS0VEX0NISUxEKTsKICBzeXNjYWxsKF9fTlJfZXhpdCwgMCk7CiAgd2hp
bGUgKDEpIHsKICB9Cn0KCnN0YXRpYyBsb25nIHN5el9jbG9uZSh2b2xhdGlsZSBsb25nIGZs
YWdzLCB2b2xhdGlsZSBsb25nIHN0YWNrLAogICAgICAgICAgICAgICAgICAgICAgdm9sYXRp
bGUgbG9uZyBzdGFja19sZW4sIHZvbGF0aWxlIGxvbmcgcHRpZCwKICAgICAgICAgICAgICAg
ICAgICAgIHZvbGF0aWxlIGxvbmcgY3RpZCwgdm9sYXRpbGUgbG9uZyB0bHMpCnsKICBsb25n
IHNwID0gKHN0YWNrICsgc3RhY2tfbGVuKSAmIH4xNTsKICBfX2F0b21pY19zdG9yZV9uKCZj
bG9uZV9vbmdvaW5nLCAxLCBfX0FUT01JQ19SRUxBWEVEKTsKICBsb25nIHJldCA9IChsb25n
KXN5c2NhbGwoX19OUl9jbG9uZSwgZmxhZ3MgJiB+Q0xPTkVfVk0sIHNwLCBwdGlkLCBjdGlk
LCB0bHMpOwogIHJldHVybiBoYW5kbGVfY2xvbmVfcmV0KHJldCk7Cn0KCnN0YXRpYyB2b2lk
IGV4ZWN1dGVfb25lKHZvaWQpOwoKI2RlZmluZSBXQUlUX0ZMQUdTIF9fV0FMTAoKc3RhdGlj
IHZvaWQgbG9vcCh2b2lkKQp7CiAgaW50IGl0ZXIgPSAwOwogIGZvciAoOzsgaXRlcisrKSB7
CiAgICBpbnQgcGlkID0gZm9yaygpOwogICAgaWYgKHBpZCA8IDApCiAgICAgIGV4aXQoMSk7
CiAgICBpZiAocGlkID09IDApIHsKICAgICAgc2V0dXBfdGVzdCgpOwogICAgICBleGVjdXRl
X29uZSgpOwogICAgICBleGl0KDApOwogICAgfQogICAgaW50IHN0YXR1cyA9IDA7CiAgICB1
aW50NjRfdCBzdGFydCA9IGN1cnJlbnRfdGltZV9tcygpOwogICAgZm9yICg7OykgewogICAg
ICBpZiAod2FpdHBpZCgtMSwgJnN0YXR1cywgV05PSEFORyB8IFdBSVRfRkxBR1MpID09IHBp
ZCkKICAgICAgICBicmVhazsKICAgICAgc2xlZXBfbXMoMSk7CiAgICAgIGlmIChjdXJyZW50
X3RpbWVfbXMoKSAtIHN0YXJ0IDwgNTAwMCkKICAgICAgICBjb250aW51ZTsKICAgICAga2ls
bF9hbmRfd2FpdChwaWQsICZzdGF0dXMpOwogICAgICBicmVhazsKICAgIH0KICB9Cn0KCnVp
bnQ2NF90IHJbMV0gPSB7MHgwfTsKCnZvaWQgZXhlY3V0ZV9vbmUodm9pZCkKewogIGludHB0
cl90IHJlcyA9IDA7CiAgc3lzY2FsbChfX05SX21sb2NrYWxsLCAxdWwpOwogIE5PTkZBSUxJ
TkcobWVtY3B5KAogICAgICAodm9pZCopMHgyMDAwMDAwMCwKICAgICAgIlx4ZThceDU1XHhh
Y1x4ODRceDFhXHhlYVx4ZDdceGZlXHg1ZFx4Y2JceDdlXHg4M1x4NzJceDdiXHhhZFx4ZDIi
LCAxNikpOwogIE5PTkZBSUxJTkcoc3l6X2Nsb25lKDAsIDB4MjAwMDAwMDAsIDB4MTAsIDAs
IDAsIDApKTsKICByZXMgPSBzeXNjYWxsKF9fTlJfc2htZ2V0LCAwdWwsIDB4MzAwMHVsLCAw
dWwsIDB4MjBmZmMwMDB1bCk7CiAgaWYgKHJlcyAhPSAtMSkKICAgIHJbMF0gPSByZXM7CiAg
c3lzY2FsbChfX05SX3NobWF0LCByWzBdLCAweDIwZmZlMDAwdWwsIDB4NDAwMHVsKTsKICBz
eXNjYWxsKF9fTlJfbWJpbmQsIDB4MjAwZTcwMDB1bCwgMHg0MDAwMDB1bCwgMHVsLCAwdWws
IDB1bCwgMnVsKTsKfQppbnQgbWFpbih2b2lkKQp7CiAgc3lzY2FsbChfX05SX21tYXAsIDB4
MWZmZmYwMDB1bCwgMHgxMDAwdWwsIDB1bCwgMHgzMnVsLCAtMSwgMHVsKTsKICBzeXNjYWxs
KF9fTlJfbW1hcCwgMHgyMDAwMDAwMHVsLCAweDEwMDAwMDB1bCwgN3VsLCAweDMydWwsIC0x
LCAwdWwpOwogIHN5c2NhbGwoX19OUl9tbWFwLCAweDIxMDAwMDAwdWwsIDB4MTAwMHVsLCAw
dWwsIDB4MzJ1bCwgLTEsIDB1bCk7CiAgaW5zdGFsbF9zZWd2X2hhbmRsZXIoKTsKICBsb29w
KCk7CiAgcmV0dXJuIDA7Cn0K

--------------R97iEtUas9IWQfHyjpjaSHmQ--
