Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA876981B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjBORQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjBORQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:16:31 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C15A25BAB;
        Wed, 15 Feb 2023 09:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676481390; x=1708017390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=Re6lTdqWh6KrFv3eII8nENMCsO1LTov6DGFipWZOh58=;
  b=DbQSlSqWzgN8BcI+ztjmiu+8aCyEv1oj1XkqsX3ig5ewevRqsX/bsDr1
   3N0wwza91yUFN3bnIIafymCp9Mxo0WVjY7GkxY8kkDIEf9BQu6nyHqDlc
   0qmk4tbDfh5yc/zLTF37VZAFWEE+DIi7272AkZFVtrQc0fwneEQeRzg6O
   SUrjUjDXjc/LjUand8inmJprrBUi5ed/mZICIiCEVrBH3MABmhRf/8m+E
   2/K2My/LiRUL8FBERF3UCa74Iy5m7/4NPoSxZSzJQZcuy7BUJUf1yiugB
   L63ocY24AV5ms3VlDq19/Pe2veCPQj4s3nVI+B5CehYpx3EhUod+jk/x2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="393890125"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="393890125"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 09:11:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="998588989"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="998588989"
Received: from chakanog-mobl.amr.corp.intel.com (HELO [10.209.64.107]) ([10.209.64.107])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 09:11:57 -0800
Content-Type: multipart/mixed; boundary="------------V56RL2ZG2Z0KQ0aAmFAITuEA"
Message-ID: <d9d18954-8434-4c85-88b8-8e1d99cd6a4b@intel.com>
Date:   Wed, 15 Feb 2023 09:11:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/7] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-5-jithu.joseph@intel.com>
 <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------V56RL2ZG2Z0KQ0aAmFAITuEA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/15/23 08:58, Dave Hansen wrote:
> On 2/14/23 15:44, Jithu Joseph wrote:
> I'd probably do something like the attached patch.  It gets rid of
> 'data' and uses sane types for the bitfield.  It does away with separate
> variables and munging into/out of the msr[] array and just passes a
> single command struct to the work function.  It doesn't have any
> uninitialized structure/bitfield fields.

Real patch attached now.

--------------V56RL2ZG2Z0KQ0aAmFAITuEA
Content-Type: text/x-patch; charset=UTF-8; name="ifs-fun.patch"
Content-Disposition: attachment; filename="ifs-fun.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lmcy9pZnMuaCBiL2Ry
aXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lmcy9pZnMuaAppbmRleCAwMGJjODZkYjExOTMu
LmZhMTMzNTA5NzZjOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWwv
aWZzL2lmcy5oCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lmcy9pZnMuaApA
QCAtMTk5LDE0ICsxOTksMTEgQEAgdW5pb24gaWZzX3N0YXR1cyB7CiB9OwogCiAvKiBNU1Jf
QVJSQVlfQklTVCBiaXQgZmllbGRzICovCi11bmlvbiBpZnNfYXJyYXkgewotCXU2NAlkYXRh
OwotCXN0cnVjdCB7Ci0JCXUzMglhcnJheV9iaXRtYXNrCQk6MzI7Ci0JCXUzMglhcnJheV9i
YW5rCQk6MTY7Ci0JCXUzMglyc3ZkCQkJOjE1OwotCQl1MzIJY3RybF9yZXN1bHQJCToxOwot
CX07CitzdHJ1Y3QgaWZzX2FycmF5IHsKKwl1MzIJYXJyYXlfYml0bWFzazsKKwl1MTYJYXJy
YXlfYmFuazsKKwl1MTYJcnN2ZAkJCToxNTsKKwl1MTYJY3RybF9yZXN1bHQJCToxOwogfTsK
IAogLyoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL2lmcy9ydW50
ZXN0LmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC9pZnMvcnVudGVzdC5jCmluZGV4
IGU3NDAwNGZhYjFhYS4uMTU4NmJjNmY1NTI5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BsYXRm
b3JtL3g4Ni9pbnRlbC9pZnMvcnVudGVzdC5jCisrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2
L2ludGVsL2lmcy9ydW50ZXN0LmMKQEAgLTI1Myw4ICsyNTMsOSBAQCBzdGF0aWMgdm9pZCB3
YWl0X2Zvcl9zaWJsaW5nX2NwdShhdG9taWNfdCAqdCwgbG9uZyBsb25nIHRpbWVvdXQpCiAK
IHN0YXRpYyBpbnQgZG9fYXJyYXlfdGVzdCh2b2lkICpkYXRhKQogeworCXN0cnVjdCBpZnNf
YXJyYXkgKmNvbW1hbmQgPSBkYXRhOwogCWludCBjcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7
Ci0JdTY0ICptc3JzID0gZGF0YTsKKwogCWludCBmaXJzdDsKIAogCS8qCkBAIC0yNjMsOSAr
MjY0LDkgQEAgc3RhdGljIGludCBkb19hcnJheV90ZXN0KHZvaWQgKmRhdGEpCiAJZmlyc3Qg
PSBjcHVtYXNrX2ZpcnN0KGNwdV9zbXRfbWFzayhjcHUpKTsKIAogCWlmIChjcHUgPT0gZmly
c3QpIHsKLQkJd3Jtc3JsKE1TUl9BUlJBWV9CSVNULCBtc3JzWzBdKTsKKwkJd3Jtc3JsKE1T
Ul9BUlJBWV9CSVNULCAqKHU2NCAqKSZjb21tYW5kKTsKIAkJLyogUGFzcyBiYWNrIHRoZSBy
ZXN1bHQgb2YgdGhlIHRlc3QgKi8KLQkJcmRtc3JsKE1TUl9BUlJBWV9CSVNULCBtc3JzWzFd
KTsKKwkJcmRtc3JsKE1TUl9BUlJBWV9CSVNULCAodTY0ICopJmNvbW1hbmQpOwogCX0KIAog
CS8qIFRlc3RzIGNvbXBsZXRlIGZhc3RlciBpZiB0aGUgc2libGluZyBpcyBzcGlubmluZyBo
ZXJlICovCkBAIC0yNzYsNDMgKzI3NywzOCBAQCBzdGF0aWMgaW50IGRvX2FycmF5X3Rlc3Qo
dm9pZCAqZGF0YSkKIAogc3RhdGljIHZvaWQgaWZzX2FycmF5X3Rlc3RfY29yZShpbnQgY3B1
LCBzdHJ1Y3QgZGV2aWNlICpkZXYpCiB7Ci0JdW5pb24gaWZzX2FycmF5IGFjdGl2YXRlLCBz
dGF0dXMgPSB7MH07CisJc3RydWN0IGlmc19hcnJheSBjb21tYW5kID0ge307CiAJYm9vbCB0
aW1lZF9vdXQgPSBmYWxzZTsKIAlzdHJ1Y3QgaWZzX2RhdGEgKmlmc2Q7CiAJdW5zaWduZWQg
bG9uZyB0aW1lb3V0OwotCXU2NCBtc3J2YWxzWzJdOwogCiAJaWZzZCA9IGlmc19nZXRfZGF0
YShkZXYpOwogCi0JYWN0aXZhdGUuYXJyYXlfYml0bWFzayA9IH4wVTsKKwljb21tYW5kLmFy
cmF5X2JpdG1hc2sgPSB+MFU7CiAJdGltZW91dCA9IGppZmZpZXMgKyBIWiAvIDI7CiAKIAlk
byB7CisJCXN0cnVjdCBpZnNfYXJyYXkgYmVmb3JlID0gY29tbWFuZDsKKwogCQlpZiAodGlt
ZV9hZnRlcihqaWZmaWVzLCB0aW1lb3V0KSkgewogCQkJdGltZWRfb3V0ID0gdHJ1ZTsKIAkJ
CWJyZWFrOwogCQl9CiAKLQkJbXNydmFsc1swXSA9IGFjdGl2YXRlLmRhdGE7Ci0KIAkJYXRv
bWljX3NldCgmYXJyYXlfY3B1c19vdXQsIDApOwotCQlzdG9wX2NvcmVfY3B1c2xvY2tlZChj
cHUsIGRvX2FycmF5X3Rlc3QsIG1zcnZhbHMpOwotCQlzdGF0dXMuZGF0YSA9IG1zcnZhbHNb
MV07CisJCXN0b3BfY29yZV9jcHVzbG9ja2VkKGNwdSwgZG9fYXJyYXlfdGVzdCwgJmNvbW1h
bmQpOwogCi0JCXRyYWNlX2lmc19hcnJheShjcHUsIGFjdGl2YXRlLCBzdGF0dXMpOwotCQlp
ZiAoc3RhdHVzLmN0cmxfcmVzdWx0KQorCQl0cmFjZV9pZnNfYXJyYXkoY3B1LCBiZWZvcmUs
IGNvbW1hbmQpOworCQlpZiAoY29tbWFuZC5jdHJsX3Jlc3VsdCkKIAkJCWJyZWFrOwogCi0J
CWFjdGl2YXRlLmFycmF5X2JpdG1hc2sgPSBzdGF0dXMuYXJyYXlfYml0bWFzazsKLQkJYWN0
aXZhdGUuYXJyYXlfYmFuayA9IHN0YXR1cy5hcnJheV9iYW5rOworCX0gd2hpbGUgKGNvbW1h
bmQuYXJyYXlfYml0bWFzayk7CiAKLQl9IHdoaWxlIChzdGF0dXMuYXJyYXlfYml0bWFzayk7
Ci0KLQlpZnNkLT5zY2FuX2RldGFpbHMgPSBzdGF0dXMuZGF0YTsKKwlpZnNkLT5zY2FuX2Rl
dGFpbHMgPSBjb21tYW5kLmRhdGE7CiAKLQlpZiAoc3RhdHVzLmN0cmxfcmVzdWx0KQorCWlm
IChjb21tYW5kLmN0cmxfcmVzdWx0KQogCQlpZnNkLT5zdGF0dXMgPSBTQ0FOX1RFU1RfRkFJ
TDsKLQllbHNlIGlmICh0aW1lZF9vdXQgfHwgc3RhdHVzLmFycmF5X2JpdG1hc2spCisJZWxz
ZSBpZiAodGltZWRfb3V0IHx8IGNvbW1hbmQuYXJyYXlfYml0bWFzaykKIAkJaWZzZC0+c3Rh
dHVzID0gU0NBTl9OT1RfVEVTVEVEOwogCWVsc2UKIAkJaWZzZC0+c3RhdHVzID0gU0NBTl9U
RVNUX1BBU1M7Cg==

--------------V56RL2ZG2Z0KQ0aAmFAITuEA--
