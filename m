Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79A75E665B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 17:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiIVPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 11:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiIVPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 11:00:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415CB7FE5F;
        Thu, 22 Sep 2022 08:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663858834; x=1695394834;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=7nTZfbTgKcz59wrRRvudFFGIKXffwGgjjoVkivFvTMU=;
  b=eEHR8imMRhQq6SgQ4l977jKIgY9/lav+SjrI/OCWVskYz9m0LseD+ivC
   tLJ9uMTjLIMgDB4hFQrmPtrEr6cC8eq6n37RakUvTzRAfHiu3n5ISM6ag
   JFbr4MJcnT+Wo2DUm39+Hpd43Mx20obaWx3Gr6v+O4/Lo5PrXHAIbvvQE
   zEICr78/g88qG/aq0cM8cA8VuyRw6VnhCu1hlUoSKu+AZreC3zqYl1NWE
   TB5pyDoUNBw2hlZ8lQVvO26kyCb1J8BIyJzM9rvFQbiaH1+crfdoQnL7/
   fJEBnLe1LQPBKgLRhVDRef90sKAYFotvdP3Ro3AxQiGRURpzVIw0O55G7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280037362"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="280037362"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 08:00:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="795119864"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO [10.209.58.200]) ([10.209.58.200])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 08:00:33 -0700
Content-Type: multipart/mixed; boundary="------------DoTHMuKmmWMwpKZvzR33ZrhJ"
Message-ID: <44b4b20a-550c-6337-3f7d-8283498f76f2@intel.com>
Date:   Thu, 22 Sep 2022 08:00:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] x86/mm: Refuse W^X violations
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org,
        Sean Christopherson <seanjc@google.com>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
 <20220921200726.GA3094503@roeck-us.net>
 <4dd594ad-490a-68ee-9e32-fbd9f135bd54@intel.com>
 <1a6e7165-cdae-6c8c-f57d-159fdb68897b@roeck-us.net>
 <d8cd7c7e-24c1-7f70-24a9-91c77aa634af@roeck-us.net>
 <YywS0keUorHwJJPt@hirez.programming.kicks-ass.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YywS0keUorHwJJPt@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DoTHMuKmmWMwpKZvzR33ZrhJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/22 00:46, Peter Zijlstra wrote:
> On Wed, Sep 21, 2022 at 08:09:13PM -0700, Guenter Roeck wrote:
> 
>> Oh well, that "helped" to hide one of the crashes. Here is another one.
>> This is with PAE enabled and booting through efi32.
> 
>> [    1.086592]  efi_runtime_update_mappings+0x36/0x42
>> [    1.086717]  efi_enter_virtual_mode+0x351/0x36e
>> [    1.086860]  start_kernel+0x57d/0x60f
>> [    1.086956]  ? set_intr_gate+0x42/0x55
>> [    1.087079]  i386_start_kernel+0x43/0x45
>> [    1.087272]  startup_32_smp+0x161/0x164
> 
> Does this help? Dave; perhaps we should just let i386 be i386 and let it
> bitrot :/

How about we just turn off enforcement for now so that the poor i386
folks can at least boot?  I have the feeling we're going to get bored
with even the warnings if they persist for too long, though.

Untested patch to make i386 violations harmless is attached.
--------------DoTHMuKmmWMwpKZvzR33ZrhJ
Content-Type: text/x-patch; charset=UTF-8; name="norefuse.patch"
Content-Disposition: attachment; filename="norefuse.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMgYi9hcmNoL3g4Ni9t
bS9wYXQvc2V0X21lbW9yeS5jCmluZGV4IDIwYjFlMjRiYWE4NS4uYzg5OWM1NWQ4MzA0IDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jCisrKyBiL2FyY2gveDg2
L21tL3BhdC9zZXRfbWVtb3J5LmMKQEAgLTU4NSw2ICs1ODUsOCBAQCBzdGF0aWMgaW5saW5l
IHBncHJvdF90IHN0YXRpY19wcm90ZWN0aW9ucyhwZ3Byb3RfdCBwcm90LCB1bnNpZ25lZCBs
b25nIHN0YXJ0LAogc3RhdGljIGlubGluZSBwZ3Byb3RfdCB2ZXJpZnlfcnd4KHBncHJvdF90
IG9sZCwgcGdwcm90X3QgbmV3LCB1bnNpZ25lZCBsb25nIHN0YXJ0LAogCQkJCSAgdW5zaWdu
ZWQgbG9uZyBwZm4sIHVuc2lnbmVkIGxvbmcgbnBnKQogeworCS8qIEp1c3Qgd2FybiBvbiBp
Mzg2LCB0aGVyZSBhcmUgc3RpbGwgdG9vIG1hbnkgaXNzdWVzIHRoZXJlOiAqLworCWJvb2wg
cmVmdXNlID0gSVNfRU5BQkxFRChDT05GSUdfWDg2XzY0KTsKIAl1bnNpZ25lZCBsb25nIGVu
ZDsKIAogCS8qIE9ubHkgZW5mb3JjZSB3aGVuIE5YIGlzIHN1cHBvcnRlZDogKi8KQEAgLTU5
OCwxMyArNjAwLDE3IEBAIHN0YXRpYyBpbmxpbmUgcGdwcm90X3QgdmVyaWZ5X3J3eChwZ3By
b3RfdCBvbGQsIHBncHJvdF90IG5ldywgdW5zaWduZWQgbG9uZyBzdGFyCiAJCXJldHVybiBu
ZXc7CiAKIAllbmQgPSBzdGFydCArIG5wZyAqIFBBR0VfU0laRSAtIDE7Ci0JV0FSTl9PTkNF
KDEsICJDUEEgcmVmdXNlIFdeWCB2aW9sYXRpb246ICUwMTZsbHggLT4gJTAxNmxseCByYW5n
ZTogMHglMDE2bHggLSAweCUwMTZseCBQRk4gJWx4XG4iLAorCVdBUk5fT05DRSgxLCAiQ1BB
ICVzV15YIHZpb2xhdGlvbjogJTAxNmxseCAtPiAlMDE2bGx4IHJhbmdlOiAweCUwMTZseCAt
IDB4JTAxNmx4IFBGTiAlbHhcbiIsCisJCSAgcmVmdXNlID8gInJlZnVzZSAiIDogIiIsCiAJ
CSAgKHVuc2lnbmVkIGxvbmcgbG9uZylwZ3Byb3RfdmFsKG9sZCksCiAJCSAgKHVuc2lnbmVk
IGxvbmcgbG9uZylwZ3Byb3RfdmFsKG5ldyksCiAJCSAgc3RhcnQsIGVuZCwgcGZuKTsKIAog
CS8qIHJlZnVzZSB0aGUgdHJhbnNpdGlvbiBpbnRvIFdYICovCi0JcmV0dXJuIG9sZDsKKwlp
ZiAocmVmdXNlKQorCQlyZXR1cm4gb2xkOworCisJcmV0dXJuIG5ldzsKIH0KIAogLyoK

--------------DoTHMuKmmWMwpKZvzR33ZrhJ--
