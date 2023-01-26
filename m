Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA38267D68F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjAZUiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjAZUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:37:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE837659C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674765430; bh=Q1Tjx1rmtKuARky73KHmwm+KOPC8klJJ3O+bRP/G2v0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jcGLQFJR0BvBFk1IqPNY/j1h1LjieQhYn9qAJFSq45ll6RQDW+BdJdFmn2dHTnoTg
         duAESJaqQXMtsfmdjOM7xAw/2GB7rGHNA5wBpo0rAOA3iuLnUDgSANgpDS4GMkY19o
         fx0s4atA3Ra2fGR8RWp+1LN03o08w94BZRA+IiqClWR3ofGs611Ao7RP3LvJrh9mCN
         gRjiXGLBe2f4zO1ygPDCcEtsA4pE49PXkBy+VkgKEQscZJroM8Prv1nJHVXrd9h8sA
         2An9vtLLm4BQm7yUoCt8xPyOdGt3lTd25CgdKPf3HfxsL8AAfs1ReYz2GNuww+9xif
         vQlbZwNxerAvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.130.156]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1pD45Z1DkN-00SKBx; Thu, 26
 Jan 2023 21:37:10 +0100
Message-ID: <804f9617-cdad-d3cb-f4c0-7d99d12f49d6@gmx.de>
Date:   Thu, 26 Jan 2023 21:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/highmem: Align-down to page the address for
 kunmap_flush_on_unmap()
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20230126143346.12086-1-fmdefrancesco@gmail.com>
 <63d2d97bce4c7_63e3f29442@iweiny-mobl.notmuch>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <63d2d97bce4c7_63e3f29442@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u4BFU7cKkIybX2YjafYiO5oIG8ou3+EqicbBfICwTIuGlIohlY8
 x+twENvBqTGTRE6ibJjx90EsajvO0mvWoaCidpYQ7+IQ467F70sSMOyXDLqGpgH02WYTRO+
 Q+IsxQRr0mUMvZh8/Wx/BUyoxTyxXyDpNsLDJh7v311vBR1xZFPNwCcSLZqJleGFaa0VJMI
 /tfX48k5EWBZQHf84nOUg==
UI-OutboundReport: notjunk:1;M01:P0:1xTPqY+rPhM=;K/7jXTCqkp172Vrr/+2AcXTgYSX
 PyW+tFf0LKoRU4wtCofhWU/gfLpZ9+TW4xAYtG2DXHKdbk9g5Agu0P7IK0NpRj+4ZaoPMbdxK
 mulNl83O/65oGwKfiOFBMeZ4MpQ89W/qrhiE5eR6ZMYwp4ujfjXl25fGegDCzySHSWaVtKY36
 5qLKxVA54sqycW0Be9v3CyJgWyGFe0phiTR6FbfIqEswG/HVDJLEfzbRg3vjj5gjFwlnRa6hJ
 A8t473FoshWC61mqPYc3vdEzuL6xXdB/GOJXEKOvRbxuWS7JnSlRTfPa5SKHNUwc1h/V+j9qW
 x0wRssf1yYu9d24BUT+yXyLJ7WBX6ooK9u597AVMZyZz2zTfSWGnO9RRuPut4b59Sl0+0Y2m2
 GNuEqzPPBoPczpi25kUzjhhQZrCeiTyT6hlCWBLLiWmgoO8ILWYtbEf6Sps9gf6t5f7fWIqig
 GXOGRdOkUohaZG6dSDoFHuJQJiOjVa2L94M7WWUGbKFnTqyjZOSj0ijsfDuD5hXQBEw5dE/N5
 CEwCob5VqVOOhuGap7xdP2tHjnLXHkQCH5Jivb2MWoCEPJtc1IiU5TNZZ3RTGcEc5Dh6ZCs87
 pUdWEpmb9YW7YAsV/VDWnAK5JquPXMOqi/SKuJC0AFNaxxuJ/TjerQxHRpVCMvqOwVBtHu5D1
 lnHfu8qLOZKwRVrRLWNYpCNP38WHb2+OhjOCPcl/WTGlzFgy29R7EwSuOo1lbfbP1mt0NEAJS
 8od/jRTBvXMsabBFLSRl3k2NQ3U7frTLZtTvl/E5IpSgan/sfINqOZS9LjthE3IBBwwVDz8Bf
 YgHI3x+KzcbVyu8S2RbhR/eAUoaT98SyBHGDNoKRl8bBxkx1pZh8B/XJFlzsotBIfhL7KAHyX
 ElVTUijKbWtv2r9yUKoA4LHC5eyQkjqdzkVNWmMlAcnIARiGwpkOK79uK3WVc5gnib3I2ye21
 9TGnxQ==
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/23 20:50, Ira Weiny wrote:
> Fabio M. De Francesco wrote:
>
> FWIW I think I would simplify the subject
> [PATCH] mm/highmem: Fix kunmap_local() on flush on unmap architectures
>
> Or something like that.
>
>> If ARCH_HAS_FLUSH_ON_KUNMAP is defined (PA-RISC case), __kunmap_local()
>> calls kunmap_flush_on_unmap(). The latter currently flushes the wrong
>> address (as confirmed by Matthew Wilcox and Helge Deller). Al Viro
>> proposed to call kunmap_flush_on_unmap() on an aligned-down to page
>> address in order to fix this issue. Consensus has been reached on this
>> solution.
>>
>> Therefore, if ARCH_HAS_FLUSH_ON_KUNMAP is defined, call
>> kunmap_flush_on_unmap() on an aligned-down to page address computed wit=
h
>> the PTR_ALIGN_DOWN() macro.
>>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
>> Confirmed-by: Helge Deller <deller@gmx.de>
>> Confirmed-by: Matthew Wilcox <willy@infradead.org>
>> Fixes: f3ba3c710ac5 ("mm/highmem: Provide kmap_local*")
>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> ---
>>
>> I have (at least) two problems with this patch...
>>
>> 1) checkpatch.pl complains about the use of the non-standard
>> "Confirmed-by" tags. I don't know how else I can give credit to Helge
>> and Matthew. However, this is not the first time that I see non-standar=
d
>> tags in patches applied upstream (I too had a non-standard
>> "Analysed-by" tag in patch which fixes a SAC bug). Any objections?
>
> I think you can add Matthew and Helge as Suggested-by:  All 3 had input =
on
> the solution.
>
>>
>> 2) I'm not sure whether or not the "Fixes" tag is appropriate in this
>> patch. Can someone either confirm or deny it?
>
> This 'fixes' looks correct to me.  I don't know how many folks are runni=
ng
> highmem with parisc but if they are I am sure they would appreciate the
> extra knowledge.

It seems nobody is running highmem on parisc, because it can't be enabled.
AFAICS, it's not in any parisc related Kconfig file.

> I do wonder if this should be cc'ed to stable to ensure it gets
> backported?  Helge do you think there is a need for that?

For correctness I think it's nevertheless good to backport it.

>>   include/linux/highmem-internal.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-i=
nternal.h
>> index 034b1106d022..e247c9ac4583 100644
>> --- a/include/linux/highmem-internal.h
>> +++ b/include/linux/highmem-internal.h
>> @@ -200,7 +200,7 @@ static inline void *kmap_local_pfn(unsigned long pf=
n)
>>   static inline void __kunmap_local(const void *addr)
>>   {
>>   #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>> -	kunmap_flush_on_unmap(addr);
>> +	kunmap_flush_on_unmap(PTR_ALIGN_DOWN(addr, PAGE_SIZE));
>>   #endif
>>   }

That would be another possibility:

diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/as=
m/cacheflush.h
index 0bdee6724132..ce5d1f8a23bd 100644
=2D-- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -77,6 +77,7 @@ void flush_anon_page(struct vm_area_struct *vma, struct =
page *page, unsigned lon
  #define ARCH_HAS_FLUSH_ON_KUNMAP
  static inline void kunmap_flush_on_unmap(const void *addr)
  {
+       addr =3D PTR_ALIGN_DOWN(addr, PAGE_SIZE);
         flush_kernel_dcache_page_addr(addr);
  }


Helge
