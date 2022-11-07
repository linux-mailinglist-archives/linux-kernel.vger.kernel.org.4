Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E773561F445
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiKGN0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKGN0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:26:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D401A113C;
        Mon,  7 Nov 2022 05:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667827589; x=1699363589;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=T37NvVQSSi6fmx6V8MNm8ZCL2U1fmLhLWZmgtaotvMY=;
  b=QiDUMJKZM9GTqZvOoo8vUZlmJyNi7vUTzyJuoBwHZnlwrQjPVn3SR2SB
   bKILCfiCCkYk4KrS81Ox3ADCqY4LieOMmzLMssRQk7CD5pPg+H3Cgx+K3
   +eg/JAZwierzD2WKh3Rx3Ujn2mwdryT5sthLCDVv77agTH+RM6q+3SGP4
   MsZrB2nQ7jc6jeeEIus3q0XiJsARXx3KTgN9AF40wpa8dSzf9QiGa7I9k
   vx0xekUwpeUFQojnoXsXJoR57e0K6eN7kFzv1r48Pq0raU1oiBaznpPlw
   cotm0kE4G+w6Cy3bdOri9Xlqyw7f8RV4TUF4dJUkQbFbryP60Sum1/fJZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="310408781"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="310408781"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 05:26:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="761093360"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="761093360"
Received: from dkthrons-mobl2.amr.corp.intel.com (HELO [10.209.29.113]) ([10.209.29.113])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 05:26:28 -0800
Content-Type: multipart/mixed; boundary="------------od00T7gMHW05lOLhDuaXZoAP"
Message-ID: <2145ca92-66f2-4411-7847-618a885c203b@intel.com>
Date:   Mon, 7 Nov 2022 05:26:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [tip: x86/urgent] x86/tdx: Prepare for using "INFO" call for a
 second purpose
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org
References: <166734513630.7716.12952231613533508782.tip-bot2@tip-bot2>
 <Y2esXPWwulendusf@zn.tnic> <d4614b70-b37b-44b8-6a9c-54d59a6f9fec@intel.com>
 <Y2gP+AT1XdapImV4@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y2gP+AT1XdapImV4@zn.tnic>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------od00T7gMHW05lOLhDuaXZoAP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/22 11:50, Borislav Petkov wrote:
> On Sun, Nov 06, 2022 at 09:02:27AM -0800, Dave Hansen wrote:
>> It's fine for now, except that the naming on this:
>>
>> -	tdx_parse_tdinfo(&cc_mask);
>> +	cc_mask = tdx_parse_tdinfo();
>>
>> is a bit funky since tdx_parse_tdinfo() is doing a couple of things
> Yeah, that was the next thing that was bothering me.
> 
>> and will need to return a second item shortly.
> Well, then rename this one back to get_cc_mask() and have a new function
> return the second item?

That's doable.  It would look something like what I've attached for now.
 The only downside to this is making two tdx_module_call(TDX_GET_INFO...)
calls.  That seems a bit wasteful, but it's not the end of the world.
It would look something like the attached patch.

I kinda like the idea of making one tdx_module_call() and parsing it all
in one place.  The calls are kinda slow, but two of them versus one
isn't going to hurt anybody.

The other thing I considered was keeping a temporary 'struct
tdx_guest_info' structure or something, filling it one, and parsing it
in get_cc_mask() and attribute checking functions.  But, that seemed
like overkill.
--------------od00T7gMHW05lOLhDuaXZoAP
Content-Type: text/x-patch; charset=UTF-8; name="tdinfo.patch"
Content-Disposition: attachment; filename="tdinfo.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jIGIvYXJjaC94ODYvY29jby90
ZHgvdGR4LmMKaW5kZXggYjg5OThjZjA1MDhhLi5hNGJmMmI2N2QzZDcgMTAwNjQ0Ci0tLSBh
L2FyY2gveDg2L2NvY28vdGR4L3RkeC5jCisrKyBiL2FyY2gveDg2L2NvY28vdGR4L3RkeC5j
CkBAIC0xMyw3ICsxMyw3IEBACiAjaW5jbHVkZSA8YXNtL3BndGFibGUuaD4KIAogLyogVERY
IG1vZHVsZSBDYWxsIExlYWYgSURzICovCi0jZGVmaW5lIFREWF9HRVRfSU5GTwkJCTEKKyNk
ZWZpbmUgVERYX0dFVF9JTkZPCQkJMSAvKiBUREcuVlAuSU5GTyAqLwogI2RlZmluZSBURFhf
R0VUX1ZFSU5GTwkJCTMKICNkZWZpbmUgVERYX0FDQ0VQVF9QQUdFCQkJNgogCkBAIC0xMDAs
MTkgKzEwMCwxMCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdGR4X21vZHVsZV9jYWxsKHU2NCBm
biwgdTY0IHJjeCwgdTY0IHJkeCwgdTY0IHI4LCB1NjQgcjksCiAJCXBhbmljKCJURENBTEwg
JWxsZCBmYWlsZWQgKEJ1Z2d5IFREWCBtb2R1bGUhKVxuIiwgZm4pOwogfQogCi1zdGF0aWMg
dm9pZCB0ZHhfcGFyc2VfdGRpbmZvKHU2NCAqY2NfbWFzaykKK3N0YXRpYyB1NjQgZ2V0X2Nj
X21hc2sodm9pZCkKIHsKIAlzdHJ1Y3QgdGR4X21vZHVsZV9vdXRwdXQgb3V0OwotCXVuc2ln
bmVkIGludCBncGFfd2lkdGg7Ci0JdTY0IHRkX2F0dHI7CiAKLQkvKgotCSAqIFRESU5GTyBU
RFggbW9kdWxlIGNhbGwgaXMgdXNlZCB0byBnZXQgdGhlIFREIGV4ZWN1dGlvbiBlbnZpcm9u
bWVudAotCSAqIGluZm9ybWF0aW9uIGxpa2UgR1BBIHdpZHRoLCBudW1iZXIgb2YgYXZhaWxh
YmxlIHZjcHVzLCBkZWJ1ZyBtb2RlCi0JICogaW5mb3JtYXRpb24sIGV0Yy4gTW9yZSBkZXRh
aWxzIGFib3V0IHRoZSBBQkkgY2FuIGJlIGZvdW5kIGluIFREWAotCSAqIEd1ZXN0LUhvc3Qt
Q29tbXVuaWNhdGlvbiBJbnRlcmZhY2UgKEdIQ0kpLCBzZWN0aW9uIDIuNC4yIFREQ0FMTAot
CSAqIFtUREcuVlAuSU5GT10uCi0JICovCiAJdGR4X21vZHVsZV9jYWxsKFREWF9HRVRfSU5G
TywgMCwgMCwgMCwgMCwgJm91dCk7CiAKIAkvKgpAQCAtMTIzLDcgKzExNCwxNSBAQCBzdGF0
aWMgdm9pZCB0ZHhfcGFyc2VfdGRpbmZvKHU2NCAqY2NfbWFzaykKIAkgKiBjYW4gbm90IG1l
YW5pbmdmdWxseSBydW4gd2l0aG91dCBpdC4KIAkgKi8KIAlncGFfd2lkdGggPSBvdXQucmN4
ICYgR0VOTUFTSyg1LCAwKTsKLQkqY2NfbWFzayA9IEJJVF9VTEwoZ3BhX3dpZHRoIC0gMSk7
CisJcmV0dXJuICBCSVRfVUxMKGdwYV93aWR0aCAtIDEpOworfQorCitzdGF0aWMgdm9pZCB0
ZHhfY2hlY2tfdGRpbmZvKHZvaWQpCit7CisJc3RydWN0IHRkeF9tb2R1bGVfb3V0cHV0IG91
dDsKKwl1NjQgdGRfYXR0cjsKKworCXRkeF9tb2R1bGVfY2FsbChURFhfR0VUX0lORk8sIDAs
IDAsIDAsIDAsICZvdXQpOwogCiAJLyoKIAkgKiBUaGUga2VybmVsIGNhbiBub3QgaGFuZGxl
ICNWRSdzIHdoZW4gYWNjZXNzaW5nIG5vcm1hbCBrZXJuZWwKQEAgLTc2OSw3ICs3NjgsOCBA
QCB2b2lkIF9faW5pdCB0ZHhfZWFybHlfaW5pdCh2b2lkKQogCXNldHVwX2ZvcmNlX2NwdV9j
YXAoWDg2X0ZFQVRVUkVfVERYX0dVRVNUKTsKIAogCWNjX3NldF92ZW5kb3IoQ0NfVkVORE9S
X0lOVEVMKTsKLQl0ZHhfcGFyc2VfdGRpbmZvKCZjY19tYXNrKTsKKwl0ZHhfY2hlY2tfdGRp
bmZvKCk7CisJY2NfbWFzayA9IGdldF9jY19tYXNrKCk7CiAJY2Nfc2V0X21hc2soY2NfbWFz
ayk7CiAKIAkvKgo=

--------------od00T7gMHW05lOLhDuaXZoAP--
