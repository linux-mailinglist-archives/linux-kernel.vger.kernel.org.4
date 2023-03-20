Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE66C0AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCTGdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCTGdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:33:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AA722A32;
        Sun, 19 Mar 2023 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679293964; x=1710829964;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Fd/G5KCuQQujS9KXOruku3RueXzTt7Ru/BXGSsi5VuU=;
  b=MzR4KjWLvjzXF8U3Fx5/NcuSwdh0Ops90HfJ4nn8KMmbxQz6I1sxNlCi
   83pzo8q718jVgqKCpWSFwn/7ZqptiXXJtxsvbkgm/9WiZVAy5zohC6q2R
   tgKf/ZIm2cFWYnWhK9Ud3xHllVe2t9AaJheop3se9a4tmNbHWDEOrnBxP
   ZIItAfuYUtnwZ7nT68V1nTyIe5Z0IqisUwX1G/WHeNVeYI9vibkGegS20
   baHw4WCiqEoaeyEEOrEkj2/K9gDn7hIb9HMW9lPUatdBExnyfR1/euzR7
   4F7olNilsn96bpuunHlSR/PKOmB/1pykCggqoTKOQvixlZjJeF3xhJGwW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="337301492"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="337301492"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 23:32:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="631009703"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="631009703"
Received: from isasover-mobl.ger.corp.intel.com ([10.209.180.176])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 23:32:39 -0700
Message-ID: <8207eb83d6b2488cfb524befdbb7184c8503f997.camel@linux.intel.com>
Subject: Re: [PATCH linux-next v2 1/3] platform/x86/intel/tpmi: Fix double
 free in tpmi_create_device()
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 19 Mar 2023 23:32:37 -0700
In-Reply-To: <3c2f9226-8741-4e51-241f-5dbac45cc794@hust.edu.cn>
References: <20230309040107.534716-1-dzm91@hust.edu.cn>
         <20230309040107.534716-2-dzm91@hust.edu.cn>
         <dd36a2ab-d465-f857-30c6-3c0094babd31@redhat.com>
         <559654bbef8483fcd53458824f23814236b0c9e0.camel@linux.intel.com>
         <40d7cb19-5712-9754-b7bd-2b582055c929@hust.edu.cn>
         <41c9e613d718095e31674f625f48c60fe493d658.camel@linux.intel.com>
         <3c2f9226-8741-4e51-241f-5dbac45cc794@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTIwIGF0IDEwOjQzICswODAwLCBEb25nbGlhbmcgTXUgd3JvdGU6Cj4g
Cj4gT24gMjAyMy8zLzE3IDE4OjI3LCBzcmluaXZhcyBwYW5kcnV2YWRhIHdyb3RlOgo+ID4gSGkg
RG9uZ2xpYW5nLAo+ID4gCj4gPiAuLi4KPiA+IC4uLgo+ID4gCj4gPiAKPiA+ID4gSGkgU3Jpbml2
YXMgYW5kIEhhbnMsCj4gPiA+IAo+ID4gPiBIb3cgYWJvdXQgZm9sZGluZyB0aGVzZSB0aHJlZSBw
YXRjaGVzIGludG8gb25lIHBhdGNoIGFuZCByZXNlbmQgYQo+ID4gPiB2Mwo+ID4gPiBwYXRjaD8K
PiA+ID4gCj4gPiA+IFRoaXMgd2lsbCBnZXQgYWxsIHBlb3BsZSB0b2dldGhlciBhbmQgYXZvaWQg
dGhlIHByZXZpb3VzCj4gPiA+IGVtYmFycmFzc2luZwo+ID4gPiBzaXRhdGlvbi4KPiA+IFRoaXMg
aXMgTk9UIGFuIGVtYmFycmFzc2luZyBzaXR1YXRpb24uCj4gPiBUaGFua3MgZm9yIGZpbmRpbmcg
YW5kIGZpeGluZyB0aGUgaXNzdWUuCj4gPiAKPiA+IFRoYW5rcywKPiA+IFNyaW5pdmFzCj4gPiAK
PiBIaSBTcmluaXZhcywKPiAKPiBBbnkgY29uY2x1c2lvbiBhYm91dCB0aGlzIHBhdGNoIHNldD8K
CkhhbnMgY2FuIHJlb3JkZXIgcGF0Y2hlcyBhcyBoZSBzdWdnZXN0ZWQgYW5kIGFwcGx5LgoKVGhh
bmtzLApTcmluaXZhcwoKPiAKPiA+ID4gRG9uZ2xpYW5nIE11Cj4gPiA+IAo+ID4gPiA+ID4gUmVn
YXJkcywKPiA+ID4gPiA+IAo+ID4gPiA+ID4gSGFucwo+ID4gPiA+ID4gCj4gPiA+ID4gPiAKPiA+
ID4gPiA+IAo+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiDCoMKgwqBkcml2
ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC90cG1pLmMgfCAxNyArKysrLS0tLS0tLS0tLS0tLQo+ID4g
PiA+ID4gPiDCoMKgwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlv
bnMoLSkKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRm
b3JtL3g4Ni9pbnRlbC90cG1pLmMKPiA+ID4gPiA+ID4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9p
bnRlbC90cG1pLmMKPiA+ID4gPiA+ID4gaW5kZXggYzk5OTczMmIwZjFlLi44ODJmZTVlNDc2M2Yg
MTAwNjQ0Cj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsL3RwbWku
Ywo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbC90cG1pLmMKPiA+
ID4gPiA+ID4gQEAgLTIxNSw4ICsyMTUsOCBAQCBzdGF0aWMgaW50IHRwbWlfY3JlYXRlX2Rldmlj
ZShzdHJ1Y3QKPiA+ID4gPiA+ID4gaW50ZWxfdHBtaV9pbmZvICp0cG1pX2luZm8sCj4gPiA+ID4g
PiA+IMKgwqAgCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgZmVhdHVyZV92c2VjX2Rl
diA9Cj4gPiA+ID4gPiA+IGt6YWxsb2Moc2l6ZW9mKCpmZWF0dXJlX3ZzZWNfZGV2KSwKPiA+ID4g
PiA+ID4gR0ZQX0tFUk5FTCk7Cj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFm
ZWF0dXJlX3ZzZWNfZGV2KSB7Cj4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXQgPSAtRU5PTUVNOwo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZ290byBmcmVlX3JlczsKPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGtmcmVlKHJlcyk7Cj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gLUVOT01FTTsKPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4g
PiA+ID4gPiA+IMKgwqAgCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgc25wcmludGYo
ZmVhdHVyZV9pZF9uYW1lLAo+ID4gPiA+ID4gPiBzaXplb2YoZmVhdHVyZV9pZF9uYW1lKSwKPiA+
ID4gPiA+ID4gInRwbWktCj4gPiA+ID4gPiA+ICVzIiwgbmFtZSk7Cj4gPiA+ID4gPiA+IEBAIC0y
NDIsMTcgKzI0Miw4IEBAIHN0YXRpYyBpbnQgdHBtaV9jcmVhdGVfZGV2aWNlKHN0cnVjdAo+ID4g
PiA+ID4gPiBpbnRlbF90cG1pX2luZm8gKnRwbWlfaW5mbywKPiA+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKiBmZWF0dXJlX3ZzZWNfZGV2IG1lbW9yeSBpcyBhbHNvIGZyZWVkIGFzIHBh
cnQKPiA+ID4gPiA+ID4gb2YKPiA+ID4gPiA+ID4gZGV2aWNlCj4gPiA+ID4gPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogZGVsZXRlLgo+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
Lwo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqByZXQgPSBpbnRlbF92c2VjX2FkZF9hdXgodnNl
Y19kZXYtPnBjaWRldiwKPiA+ID4gPiA+ID4gJnZzZWNfZGV2LQo+ID4gPiA+ID4gPiA+IGF1eGRl
di5kZXYsCj4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmZWF0dXJlX3ZzZWNfZGV2LAo+ID4gPiA+ID4gPiBm
ZWF0dXJlX2lkX25hbWUpOwo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqBpZiAocmV0KQo+ID4g
PiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBmcmVlX3JlczsKPiA+
ID4gPiA+ID4gLQo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+ID4gPiA+
ID4gLQo+ID4gPiA+ID4gPiAtZnJlZV9yZXM6Cj4gPiA+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoGtm
cmVlKHJlcyk7Cj4gPiA+ID4gPiA+IC0KPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoMKgcmV0dXJu
IHJldDsKPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGludGVsX3ZzZWNfYWRkX2F1
eCh2c2VjX2Rldi0+cGNpZGV2LAo+ID4gPiA+ID4gPiAmdnNlY19kZXYtCj4gPiA+ID4gPiA+ID4g
YXV4ZGV2LmRldiwKPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmVhdHVyZV92c2VjX2RldiwKPiA+ID4g
PiA+ID4gZmVhdHVyZV9pZF9uYW1lKTsKPiA+ID4gPiA+ID4gwqDCoMKgfQo+ID4gPiA+ID4gPiDC
oMKgIAo+ID4gPiA+ID4gPiDCoMKgwqBzdGF0aWMgaW50IHRwbWlfY3JlYXRlX2RldmljZXMoc3Ry
dWN0IGludGVsX3RwbWlfaW5mbwo+ID4gPiA+ID4gPiAqdHBtaV9pbmZvKQoK

