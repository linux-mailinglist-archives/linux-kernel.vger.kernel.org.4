Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECA5661CB9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjAIDeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjAIDeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:34:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A458195A5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:34:18 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3091p8F8007748;
        Mon, 9 Jan 2023 03:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZIx+xqWPKbq/9ddgOdDpRaZ9E50KsR77bOA82Jvw+7o=;
 b=eMhfhSEXa1JOljD5P66kBRYq04DgLPXS8M+NeFdBfhiIOSdxQB/5WPJNQ8ceBIYwN5qK
 F9chv96JeBz5akftlgsBRnYBiFo0omQ00yB2+yDxsgGPVFa7aIwtSwzxIsPEhwXX+0bZ
 AyUwVWa28R22JUDqe/ar5Uj1poqr7SwcPfclL9PAsFLON+cGIvbZRCrXzFsRb+9kvtbq
 Wsy9SLI9eUQ3/rt5iHk4utSzCt45JmrlKowPb9axLcMgpPxwafdw6zI4x4n2CzT+f4VB
 5BRPYF7XahW6B3uHUAepmrlSogqE6u5IAfoFfymb3wCmr800zFHbHOhcfI3fAoDO0VEU Wg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3myjw32nuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 03:34:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 308FkYCv000526;
        Mon, 9 Jan 2023 03:34:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3my0c6j9vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 03:34:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3093Xx6U42270996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jan 2023 03:33:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0682820049;
        Mon,  9 Jan 2023 03:33:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 098B620040;
        Mon,  9 Jan 2023 03:33:58 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jan 2023 03:33:57 +0000 (GMT)
Received: from [10.61.2.128] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id CBD52600D2;
        Mon,  9 Jan 2023 14:33:52 +1100 (AEDT)
Message-ID: <964d9b37c58301b026be7a58588f8f990ce4c059.camel@linux.ibm.com>
Subject: Re: [PATCH v2 7/7] powerpc/pseries: Implement secvars for dynamic
 secure boot
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>,
        linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        zohar@linux.ibm.com
Date:   Mon, 09 Jan 2023 14:33:52 +1100
In-Reply-To: <87zgawgcpa.fsf@mpe.ellerman.id.au>
References: <20221230042014.154483-1-ruscur@russell.cc>
         <20221230042014.154483-8-ruscur@russell.cc>
         <87zgawgcpa.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5LW_lLLzw6zufdtPd9mY-sGFf65p9G4a
X-Proofpoint-GUID: 5LW_lLLzw6zufdtPd9mY-sGFf65p9G4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTA2IGF0IDIxOjQ5ICsxMTAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3Rl
Ogo+ID4gK1doYXQ6wqDCoMKgwqDCoMKgwqDCoMKgwqAvc3lzL2Zpcm13YXJlL3NlY3Zhci9jb25m
aWcvc3VwcG9ydGVkX3BvbGljaWVzCj4gPiArRGF0ZTrCoMKgwqDCoMKgwqDCoMKgwqDCoERlY2Vt
YmVyIDIwMjIKPiA+ICtDb250YWN0OsKgwqDCoMKgwqDCoMKgTmF5bmEgSmFpbiA8bmF5bmFAbGlu
dXguaWJtLmNvbT4KPiA+ICtEZXNjcmlwdGlvbjrCoMKgwqBSTyBmaWxlLCBvbmx5IHByZXNlbnQg
aWYgdGhlIHNlY3ZhciBpbXBsZW1lbnRhdGlvbgo+ID4gaXMgUExQS1MuCj4gPiArCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQ29udGFpbnMgYSBiaXRtYXNrIG9mIHN1cHBvcnRl
ZCBwb2xpY3kgZmxhZ3MgYnkgdGhlCj4gPiBoeXBlcnZpc29yLAo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJlcHJlc2VudGVkIGFzIGFuIDggYnl0ZSBoZXhhZGVjaW1hbCBBU0NJ
SSBzdHJpbmcuwqAKPiA+IENvbnN1bHQgdGhlCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaHlwZXJ2aXNvciBkb2N1bWVudGF0aW9uIGZvciB3aGF0IHRoZXNlIGZsYWdzIGFyZS4K
PiA+ICsKPiA+ICtXaGF0OsKgwqDCoMKgwqDCoMKgwqDCoMKgL3N5cy9maXJtd2FyZS9zZWN2YXIv
Y29uZmlnL3NpZ25lZF91cGRhdGVfYWxnb3JpdGhtCj4gPiBzCj4gPiArRGF0ZTrCoMKgwqDCoMKg
wqDCoMKgwqDCoERlY2VtYmVyIDIwMjIKPiA+ICtDb250YWN0OsKgwqDCoMKgwqDCoMKgTmF5bmEg
SmFpbiA8bmF5bmFAbGludXguaWJtLmNvbT4KPiA+ICtEZXNjcmlwdGlvbjrCoMKgwqBSTyBmaWxl
LCBvbmx5IHByZXNlbnQgaWYgdGhlIHNlY3ZhciBpbXBsZW1lbnRhdGlvbgo+ID4gaXMgUExQS1Mu
Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQ29udGFpbnMgYSBiaXRt
YXNrIG9mIGZsYWdzIGluZGljYXRpbmcgd2hpY2gKPiA+IGFsZ29yaXRobXMgdGhlCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaHlwZXJ2aXNvciBzdXBwb3J0cyBvYmplY3RzIHRv
IGJlIHNpZ25lZCB3aXRoIHdoZW4KPiA+IG1vZGlmeWluZwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHNlY3ZhcnMsIHJlcHJlc2VudGVkIGFzIGEgMTYgYnl0ZSBoZXhhZGVjaW1h
bCBBU0NJSQo+ID4gc3RyaW5nLgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoENv
bnN1bHQgdGhlIGh5cGVydmlzb3IgZG9jdW1lbnRhdGlvbiBmb3Igd2hhdCB0aGVzZQo+ID4gZmxh
Z3MgbWVhbi4KPiDCoAo+IENhbiB0aGlzIGF0IGxlYXN0IHNheSAiYXMgZGVmaW5lZCBpbiBQQVBS
IHZlcnNpb24gWCBzZWN0aW9uIFkiPwoKV2UgZG9uJ3QgY3VycmVudGx5IGhhdmUgYSBQQVBSIHJl
ZmVyZW5jZSBmb3IgdGhpcyAtIHRoYXQgd2lsbCBjb21lCmV2ZW50dWFsbHkuCgo+IAo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9LY29uZmlnCj4gPiBiL2Fy
Y2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9LY29uZmlnCj4gPiBpbmRleCBhM2I0ZDk5NTY3
Y2IuLjk0ZTA4YzQwNWQ1MCAxMDA2NDQKPiA+IC0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
cHNlcmllcy9LY29uZmlnCj4gPiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMv
S2NvbmZpZwo+ID4gQEAgLTE2Miw2ICsxNjIsMTkgQEAgY29uZmlnIFBTRVJJRVNfUExQS1MKPiA+
IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgSWYgdW5zdXJlLCBzZWxlY3QgTi4KPiA+IMKgCj4g
PiArY29uZmlnIFBTRVJJRVNfUExQS1NfU0VDVkFSCj4gPiArwqDCoMKgwqDCoMKgwqBkZXBlbmRz
IG9uIFBTRVJJRVNfUExQS1MKPiA+ICvCoMKgwqDCoMKgwqDCoGRlcGVuZHMgb24gUFBDX1NFQ1VS
RV9CT09UCj4gPiArwqDCoMKgwqDCoMKgwqBib29sICJTdXBwb3J0IGZvciB0aGUgUExQS1Mgc2Vj
dmFyIGludGVyZmFjZSIKPiA+ICvCoMKgwqDCoMKgwqDCoGhlbHAKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgIFBvd2VyVk0gY2FuIHN1cHBvcnQgZHluYW1pYyBzZWN1cmUgYm9vdCB3aXRoIHVzZXItZGVm
aW5lZAo+ID4ga2V5cwo+ID4gK8KgwqDCoMKgwqDCoMKgwqAgdGhyb3VnaCB0aGUgUExQS1MuIEtl
eXN0b3JlIG9iamVjdHMgdXNlZCBpbiBkeW5hbWljCj4gPiBzZWN1cmUgYm9vdAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqAgY2FuIGJlIGV4cG9zZWQgdG8gdGhlIGtlcm5lbCBhbmQgdXNlcnNwYWNlIHRo
cm91Z2ggdGhlCj4gPiBwb3dlcnBjCj4gPiArwqDCoMKgwqDCoMKgwqDCoCBzZWN2YXIgaW5mcmFz
dHJ1Y3R1cmUuIFNlbGVjdCB0aGlzIHRvIGVuYWJsZSB0aGUgUExQS1MKPiA+IGJhY2tlbmQKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgIGZvciBzZWN2YXJzIGZvciB1c2UgaW4gcHNlcmllcyBkeW5hbWlj
IHNlY3VyZSBib290Lgo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqAgSWYgdW5zdXJlLCBzZWxl
Y3QgTi4KPiAKPiBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdGhhdCBjb25maWcgb3B0aW9uIGF0IGFs
bCwgb3IgaWYgd2UgZG8gaXQKPiBzaG91bGQKPiBub3QgYmUgdXNlciBzZWxlY3RhYmxlIGFuZCBq
dXN0IGVuYWJsZWQgYXV0b21hdGljYWxseSBieQo+IFBTRVJJRVNfUExQS1MuCj4gCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wc2VyaWVzL01ha2VmaWxlCj4gPiBiL2Fy
Y2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmllcy9NYWtlZmlsZQo+ID4gaW5kZXggOTIzMTAyMDJi
ZGQ3Li44MDc3NTY5OTFmOWQgMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1z
L3BzZXJpZXMvTWFrZWZpbGUKPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcHNlcmll
cy9NYWtlZmlsZQo+ID4gQEAgLTI3LDggKzI3LDggQEAgb2JqLSQoQ09ORklHX1BBUFJfU0NNKcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKz0KPiA+IHBhcHJfc2NtLm8KPiA+IMKgb2Jq
LSQoQ09ORklHX1BQQ19TUExQQVIpwqDCoMKgwqDCoMKgwqArPSB2cGhuLm8KPiA+IMKgb2JqLSQo
Q09ORklHX1BQQ19TVk0pwqDCoMKgwqDCoMKgwqDCoMKgwqArPSBzdm0ubwo+ID4gwqBvYmotJChD
T05GSUdfRkFfRFVNUCnCoMKgwqDCoMKgwqDCoMKgwqDCoCs9IHJ0YXMtZmFkdW1wLm8KPiA+IC1v
YmotJChDT05GSUdfUFNFUklFU19QTFBLUykgKz0gcGxwa3Mubwo+ID4gLQo+ID4gK29iai0kKENP
TkZJR19QU0VSSUVTX1BMUEtTKcKgwqDCoMKgKz0gcGxwa3Mubwo+ID4gK29iai0kKENPTkZJR19Q
U0VSSUVTX1BMUEtTX1NFQ1ZBUinCoMKgwqDCoMKgKz0gcGxwa3Mtc2VjdmFyLm8KPiAKPiBJJ20g
bm90IGNvbnZpbmNlZCB0aGUgc2VjdmFyIHBhcnRzIG5lZWQgdG8gYmUgaW4gYSBzZXBhcmF0ZSBD
IGZpbGUuCj4gCj4gSWYgaXQgd2FzIGFsbCBpbiBwbHBrcy5jIHdlIGNvdWxkIGF2b2lkIGFsbC9t
b3N0IG9mIHBscGtzLmggYW5kIGEKPiBidW5jaAo+IG9mIGFjY2Vzc29ycyBhbmQgc28gb24uCj4g
Cj4gQnV0IEkgZG9uJ3QgZmVlbCB0aGF0IHN0cm9uZ2x5IGFib3V0IGl0IGlmIHlvdSB0aGluayBp
dCdzIGJldHRlcgo+IHNlcGFyYXRlLgoKSSBmZWVsIHByZXR0eSBzdHJvbmdseSB0aGF0IHdlIHNo
b3VsZCBrZWVwIGl0IHNlcGFyYXRlLiBXZSdyZSBnb2luZyB0bwpuZWVkIGEgaGVhZGVyIGZpbGUg
YW55d2F5IGJlY2F1c2UgaW4gZnV0dXJlIHBhdGNoZXMgdG8gY29tZSBzaG9ydGx5IHdlCm5lZWQg
dG8gd2lyZSBwbHBrcyB1cCB3aXRoIHRoZSBpbnRlZ3JpdHkgc3Vic3lzdGVtIHRvIGxvYWQga2V5
cyBpbnRvCmtlcm5lbCBrZXlyaW5ncy4KCj4gCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBj
L3BsYXRmb3Jtcy9wc2VyaWVzL3BscGtzLXNlY3Zhci5jCj4gPiBiL2FyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvcHNlcmllcy9wbHBrcy1zZWN2YXIuYwo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+
IGluZGV4IDAwMDAwMDAwMDAwMC4uODI5OGYwMzliZWY0Cj4gPiAtLS0gL2Rldi9udWxsCj4gPiAr
KysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3BzZXJpZXMvcGxwa3Mtc2VjdmFyLmMKPiA+IEBA
IC0wLDAgKzEsMjQ1IEBACj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b25seQo+ID4gKy8qCj4gPiArICogU2VjdXJlIHZhcmlhYmxlIGltcGxlbWVudGF0aW9uIHVzaW5n
IHRoZSBQb3dlclZNIExQQVIgUGxhdGZvcm0KPiA+IEtleVN0b3JlIChQTFBLUykKPiA+ICsgKgo+
ID4gKyAqIENvcHlyaWdodCAyMDIyLCBJQk0gQ29ycG9yYXRpb24KPiA+ICsgKiBBdXRob3JzOiBS
dXNzZWxsIEN1cnJleQo+ID4gKyAqwqDCoMKgwqDCoMKgwqDCoMKgIEFuZHJldyBEb25uZWxsYW4K
PiA+ICsgKsKgwqDCoMKgwqDCoMKgwqDCoCBOYXluYSBKYWluCj4gPiArICovCj4gPiArCj4gPiAr
I2RlZmluZSBwcl9mbXQoZm10KSAic2VjdmFyOiAiZm10Cj4gPiArCj4gPiArI2luY2x1ZGUgPGxp
bnV4L3ByaW50ay5oPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+Cj4gPiArI2luY2x1ZGUg
PGxpbnV4L3R5cGVzLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KPiA+ICsjaW5jbHVk
ZSA8bGludXgvc3RyaW5nLmg+Cj4gPiArI2luY2x1ZGUgPGxpbnV4L2tvYmplY3QuaD4KPiA+ICsj
aW5jbHVkZSA8YXNtL3NlY3Zhci5oPgo+ID4gKyNpbmNsdWRlICJwbHBrcy5oIgo+ID4gKwo+ID4g
Ky8vIENvbmZpZyBhdHRyaWJ1dGVzIGZvciBzeXNmcwo+ID4gKyNkZWZpbmUgUExQS1NfQ09ORklH
X0FUVFIobmFtZSwgZm10LCBmdW5jKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoFwKPiA+ICvCoMKgwqDCoMKgwqDCoHN0YXRpYyBzc2l6ZV90IG5hbWUjI19zaG93KHN0
cnVjdCBrb2JqZWN0ICprb2JqLMKgwqDCoMKgwqDCoMKgwqBcCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVj
dCBrb2JqX2F0dHJpYnV0ZSAqYXR0cizCoFwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2hhciAqYnVmKcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+ID4gK8KgwqDCoMKgwqDCoMKge8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgXAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBzeXNmc19lbWl0KGJ1ZiwgZm10
LCBmdW5jKCkpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwKPiA+ICvCoMKgwqDCoMKgwqDCoH3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwKPiA+
ICvCoMKgwqDCoMKgwqDCoHN0YXRpYyBzdHJ1Y3Qga29ial9hdHRyaWJ1dGUgYXR0cl8jI25hbWUg
PSBfX0FUVFJfUk8obmFtZSkKPiA+ICsKPiA+ICtQTFBLU19DT05GSUdfQVRUUih2ZXJzaW9uLCAi
JXVcbiIsIHBscGtzX2dldF92ZXJzaW9uKTsKPiA+ICtQTFBLU19DT05GSUdfQVRUUihtYXhfb2Jq
ZWN0X3NpemUsICIldVxuIiwKPiA+IHBscGtzX2dldF9tYXhvYmplY3RzaXplKTsKPiA+ICtQTFBL
U19DT05GSUdfQVRUUih0b3RhbF9zaXplLCAiJXVcbiIsIHBscGtzX2dldF90b3RhbHNpemUpO2xl
cwo+ID4gK1BMUEtTX0NPTkZJR19BVFRSKHVzZWRfc3BhY2UsICIldVxuIiwgcGxwa3NfZ2V0X3Vz
ZWRzcGFjZSk7Cj4gPiArUExQS1NfQ09ORklHX0FUVFIoc3VwcG9ydGVkX3BvbGljaWVzLCAiJTA4
eFxuIiwKPiA+IHBscGtzX2dldF9zdXBwb3J0ZWRwb2xpY2llcyk7Cj4gPiArUExQS1NfQ09ORklH
X0FUVFIoc2lnbmVkX3VwZGF0ZV9hbGdvcml0aG1zLCAiJTAxNmxseFxuIiwKPiA+IHBscGtzX2dl
dF9zaWduZWR1cGRhdGVhbGdvcml0aG1zKTsKPiAKPiBGb3IgdGhvc2UgbGFzdCB0d28gSSB3b25k
ZXIgaWYgd2Ugc2hvdWxkIGJlIGRlY29kaW5nIHRoZSBpbnRlZ2VyCj4gdmFsdWVzCj4gaW50byBh
IGNvbW1hIHNlcGFyYXRlZCBsaXN0IG9mIG5hbWVkIGZsYWdzPwo+IAo+IEp1c3QgYmxhdHRpbmcg
b3V0IHRoZSBpbnRlZ2VyIHZhbHVlcyBpcyBhIGJpdCBncm9zcy4gSXQncyBub3QgaGVscGZ1bAo+
IGZvciBzaGVsbCBzY3JpcHRzLCBhbmQgYSBjb25zdW1lciB3cml0dGVuIGluIEMgaGFzIHRvIHN0
cnRvdWxsKCkgdGhlCj4gdmFsdWUgYmFjayBpbnRvIGFuIGludGVnZXIgYmVmb3JlIGl0IGNhbiBk
ZWNvZGUgaXQuCgpIb3cgd291bGQgeW91IHByb3Bvc2UgZGVhbGluZyB3aXRoIGN1cnJlbnRseS1y
ZXNlcnZlZCBiaXRzIHRoYXQgbWlnaHQKYmUgdXNlZCBieSBhIGZ1dHVyZSB2ZXJzaW9uIG9mIHRo
ZSBoeXBlcnZpc29yPwoKPiAKPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZSAqY29u
ZmlnX2F0dHJzW10gPSB7Cj4gPiArwqDCoMKgwqDCoMKgwqAmYXR0cl92ZXJzaW9uLmF0dHIsCj4g
PiArwqDCoMKgwqDCoMKgwqAmYXR0cl9tYXhfb2JqZWN0X3NpemUuYXR0ciwKPiA+ICvCoMKgwqDC
oMKgwqDCoCZhdHRyX3RvdGFsX3NpemUuYXR0ciwKPiA+ICvCoMKgwqDCoMKgwqDCoCZhdHRyX3Vz
ZWRfc3BhY2UuYXR0ciwKPiA+ICvCoMKgwqDCoMKgwqDCoCZhdHRyX3N1cHBvcnRlZF9wb2xpY2ll
cy5hdHRyLAo+ID4gK8KgwqDCoMKgwqDCoMKgJmF0dHJfc2lnbmVkX3VwZGF0ZV9hbGdvcml0aG1z
LmF0dHIsCj4gPiArwqDCoMKgwqDCoMKgwqBOVUxMLAo+ID4gK307Cj4gPiArCj4gPiArc3RhdGlj
IHUxNiBnZXRfdWNzMm5hbWUoY29uc3QgY2hhciAqbmFtZSwgdWludDhfdCAqKnVjczJfbmFtZSkK
PiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKgwqBpbnQgbmFtZWxlbiA9IHN0cmxlbihuYW1lKSAqIDI7
Cj4gPiArwqDCoMKgwqDCoMKgwqAqdWNzMl9uYW1lID0ga3phbGxvYyhuYW1lbGVuLCBHRlBfS0VS
TkVMKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghKnVjczJfbmFtZSkKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqDCoGZvciAoaW50IGkgPSAwOyBuYW1lW2ldOyBpKyspIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAoKnVjczJfbmFtZSlbaSAqIDJdID0gbmFtZVtpXTsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoKnVjczJfbmFtZSlbaSAqIDIgKyAxXSA9ICdcMCc7Cj4g
PiArwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gbmFtZWxl
bjsKPiA+ICt9Cj4gCj4gVGhlcmUgYXJlIHNvbWUgdWNzMiByb3V0aW5lcyBpbiBsaWIvdWNzMl9z
dHJpbmcuYywgY2FuIHdlIHVzZSBhbnkgb2YKPiB0aGVtPwoKdWNzMl9zdHJpbmcuYyBkb2Vzbid0
IGRvIHRoaXMuCgoKLS0gCkFuZHJldyBEb25uZWxsYW4gICAgT3pMYWJzLCBBREwgQ2FuYmVycmEK
YWpkQGxpbnV4LmlibS5jb20gICBJQk0gQXVzdHJhbGlhIExpbWl0ZWQK

