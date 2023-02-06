Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AE168C445
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjBFRLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBFRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:11:04 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0B414238;
        Mon,  6 Feb 2023 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675703463; x=1707239463;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=Ja5SdUOZuIIC30ACklv9jVK1neyxgWVY60XVa305tTE=;
  b=ZChkClE4XrdISxAWCyHpaKHS3G2VzhPLxqDz6+2CghG3DrQFNnaAaE/0
   0PJqd14OatarVDCiyI6nlarJI+IJ/Q8LeQQZ/wuJir48h++t3RMMx6+qe
   7pJ/zmqhMcTk8ohE8WlXWDqapNQsr5RCnrkjTn26dQHP75ONK/jEuWfbf
   EQyV7dmlyh1UXb1kLc1+HAY6CBs0W1iClFeo437CZ03GYLAwhrggJhnBt
   NJwNRGr8d1M4TU71TCoEbLCAmbOiSZkpc/gsC6cOz2veucFPARloN7R8W
   88j8kLYa2EhREqEEffJvseByFIb/9prNsh9X4Hp6yxTzbFosRlZmFaqDi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="326944277"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="326944277"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 09:10:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="840423329"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="840423329"
Received: from ninhngo-mobl.amr.corp.intel.com (HELO [10.212.134.105]) ([10.212.134.105])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 09:10:53 -0800
Content-Type: multipart/mixed; boundary="------------FG0mL8VM1uuFILP0dHf2P0I2"
Message-ID: <1dbc9402-5baf-4a92-96b3-8b3a9c108f01@intel.com>
Date:   Mon, 6 Feb 2023 09:10:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] x86/sgx: Avoid using iterator after loop in
 sgx_mmu_notifier_release()
Content-Language: en-US
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20230206-sgx-use-after-iter-v1-1-c09fb5300b5e@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230206-sgx-use-after-iter-v1-1-c09fb5300b5e@gmail.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FG0mL8VM1uuFILP0dHf2P0I2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/23 02:39, Jakob Koschel wrote:
> If &encl_mm->encl->mm_list does not contain the searched 'encl_mm',
> 'tmp' will not point to a valid sgx_encl_mm struct.
> 
> Since the code within the guarded block is just called when the element
> is found, it can simply be moved into the list iterator.
> Within the list iterator 'tmp' is guaranteed to point to a valid
> element.
> 
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> ---
> Linus proposed to avoid any use of the list iterator variable after the
> loop, in the attempt to move the list iterator variable declaration into
> the marcro to avoid any potential misuse after the loop.
> Using it in a pointer comparision after the loop is undefined behavior
> and should be omitted if possible [1].

I think there's a big difference between "undefined behavior" and
"someone wants to flip a switch to *make* this undefined behavior".  My
understanding is that this patch avoids behavior which _is_ defined today.

Is there some effort to change this behavior across the tree that I missed?

In any case, this patch also kinda breaks the rule that you're supposed
to make the common path through the code at the lowest nesting level.
It makes the common case look like some kind of error handling.  Would
something like the attached patch work?
--------------FG0mL8VM1uuFILP0dHf2P0I2
Content-Type: text/x-patch; charset=UTF-8; name="sgxmm.patch"
Content-Disposition: attachment; filename="sgxmm.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VuY2wuYyBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvc2d4L2VuY2wuYwppbmRleCA2OGY4YjE4ZDIyNzguLmUxYmQyYTU3OTBh
NyAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvZW5jbC5jCisrKyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvc2d4L2VuY2wuYwpAQCAtNzU1LDYgKzc1NSw3IEBAIHN0YXRp
YyB2b2lkIHNneF9tbXVfbm90aWZpZXJfcmVsZWFzZShzdHJ1Y3QgbW11X25vdGlmaWVyICpt
biwKIHsKIAlzdHJ1Y3Qgc2d4X2VuY2xfbW0gKmVuY2xfbW0gPSBjb250YWluZXJfb2YobW4s
IHN0cnVjdCBzZ3hfZW5jbF9tbSwgbW11X25vdGlmaWVyKTsKIAlzdHJ1Y3Qgc2d4X2VuY2xf
bW0gKnRtcCA9IE5VTEw7CisJYm9vbCBtbV9mb3VuZCA9IGZhbHNlOwogCiAJLyoKIAkgKiBU
aGUgZW5jbGF2ZSBpdHNlbGYgY2FuIHJlbW92ZSBlbmNsX21tLiAgTm90ZSwgb2JqZWN0cyBj
YW4ndCBiZSBtb3ZlZApAQCAtNzY0LDEyICs3NjUsMTMgQEAgc3RhdGljIHZvaWQgc2d4X21t
dV9ub3RpZmllcl9yZWxlYXNlKHN0cnVjdCBtbXVfbm90aWZpZXIgKm1uLAogCWxpc3RfZm9y
X2VhY2hfZW50cnkodG1wLCAmZW5jbF9tbS0+ZW5jbC0+bW1fbGlzdCwgbGlzdCkgewogCQlp
ZiAodG1wID09IGVuY2xfbW0pIHsKIAkJCWxpc3RfZGVsX3JjdSgmZW5jbF9tbS0+bGlzdCk7
CisJCQltbV9mb3VuZCA9IHRydWU7CiAJCQlicmVhazsKIAkJfQogCX0KIAlzcGluX3VubG9j
aygmZW5jbF9tbS0+ZW5jbC0+bW1fbG9jayk7CiAKLQlpZiAodG1wID09IGVuY2xfbW0pIHsK
KwlpZiAobW1fZm91bmQpIHsKIAkJc3luY2hyb25pemVfc3JjdSgmZW5jbF9tbS0+ZW5jbC0+
c3JjdSk7CiAJCW1tdV9ub3RpZmllcl9wdXQobW4pOwogCX0K

--------------FG0mL8VM1uuFILP0dHf2P0I2--
