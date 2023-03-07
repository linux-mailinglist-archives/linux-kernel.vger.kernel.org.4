Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094186ADA21
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCGJUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjCGJUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:20:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEB986DE7;
        Tue,  7 Mar 2023 01:19:59 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3278dD1o032155;
        Tue, 7 Mar 2023 09:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=OjKY7gpoc92MrBAieztC3xyMvwQnw4OrLb8s0/9FybQ=;
 b=KPgOpwZypOJlaMyaSBjH+/lQRpOvhT2U5ZI20/+Dn2do+9KNOP231IVuOcib4My4gjKt
 njWdVKncdC9a92X6FYj0tzMT4OcZ8YOZlqn5yef5YWjhifkKbtCyI5pKpg1NZzKWkcb1
 Iwy1Pw3GbvbysSOu937MmhURjqj/IRxhZgBKnkD5WBr3iRob8JDlEen367A/QBVeon4E
 grj5rlNqv4IeFTcUl5mNeRhTqlmDxKbWUN16XW8Pc3uhtEsp4svTAw8E6hXEq8S7volv
 LDYJp0GBiC1uB//nqRodTukqdyPjCykAdumlrRIGy0eBad++tJhOf5EBrkBVzfEb1gZy FA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p50vn8vm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 09:19:42 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32724W9l005734;
        Tue, 7 Mar 2023 09:19:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p41brc0ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 09:19:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3279JaGt37093720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 09:19:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B7A920043;
        Tue,  7 Mar 2023 09:19:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8CD120040;
        Tue,  7 Mar 2023 09:19:35 +0000 (GMT)
Received: from [9.152.212.247] (unknown [9.152.212.247])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Mar 2023 09:19:35 +0000 (GMT)
Message-ID: <a3a4351375d51aa5e93e06bba212ba3637665885.camel@linux.ibm.com>
Subject: Re: [syzbot] [block?] WARNING in blkdev_put (2)
From:   Julian Ruess <julianr@linux.ibm.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        syzbot+2bcc0d79e548c4f62a59@syzkaller.appspotmail.com
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        jack@suse.cz, hch@lst.de, Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        "yukuai (C)" <yukuai3@huawei.com>, julianr@linux.ibm.com
Date:   Tue, 07 Mar 2023 10:19:35 +0100
In-Reply-To: <26079e08-857d-6216-0921-bdef369f3316@huaweicloud.com>
References: <87lekfne28.fsf@oc8242746057.ibm.com>
         <f9649d501bc8c3444769418f6c26263555d9d3be.camel@linux.ibm.com>
         <26079e08-857d-6216-0921-bdef369f3316@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3fSMVfqPKXuSzuMK4QSE5DKG1UO4rvdA
X-Proofpoint-ORIG-GUID: 3fSMVfqPKXuSzuMK4QSE5DKG1UO4rvdA
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_03,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 spamscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303070082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAzLTA3IGF0IDA5OjQyICswODAwLCBZdSBLdWFpIHdyb3RlOgo+IEhpLAo+
IAo+IOWcqCAyMDIzLzAzLzA2IDIzOjAwLCBKdWxpYW4gUnVlc3Mg5YaZ6YGTOgo+ID4gT24gVGh1
LCAyMDIzLTAzLTAyIGF0IDIwOjMzICswMTAwLCBBbGV4YW5kZXIgRWdvcmVua292IHdyb3RlOgo+
ID4gPiAKPiA+ID4gSGksCj4gPiA+IAo+ID4gPiB3ZSBhcmUgc2VlaW5nIGEgc2ltaWxhciBwcm9i
bGVtIG9uIHMzOTB4IGFyY2hpdGVjdHVyZSB3aGVuCj4gPiA+IHBhcnRpdGlvbmluZwo+ID4gPiBh
IE5WTWUgZGlzayBvbiBsaW51eC1uZXh0Lgo+ID4gPiAKPiA+ID4gCj4gPiA+IMKgwqAgW8KgwqAg
NzAuNDAzMDE1XcKgIG52bWUwbjE6IHAxCj4gPiA+IMKgwqAgW8KgwqAgNzAuNDAzMTk3XSAtLS0t
LS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0KPiA+ID4gwqDCoCBbwqDCoCA3MC40MDMx
OTldIFdBUk5JTkc6IENQVTogOCBQSUQ6IDI0NTIgYXQgYmxvY2svYmRldi5jOjg0NQo+ID4gPiBi
bGtkZXZfcHV0KzB4MjgwLzB4Mjk4Cj4gPiAKPiA+IC4uLgo+ID4gCj4gPiA+IFRoZSBwcm9ibGVt
IGFwcGVhcmVkIGFib3V0IGEgd2VlayBhZ28uCj4gPiA+IAo+ID4gPiBSZWdhcmRzCj4gPiA+IEFs
ZXgKPiA+IAo+ID4gSGkgYWxsLAo+ID4gCj4gPiBJIGJpc2VjdGVkIHRoaXMgdG86Cj4gPiAKPiA+
IGNvbW1pdCBlNWNmZWZhOTdiY2NmOTU2ZWEwYmI2NDY0YzFmNmM4NGZkN2E4ZDlmCj4gPiBBdXRo
b3I6IFl1IEt1YWkgPHl1a3VhaTNAaHVhd2VpLmNvbT4KPiA+IERhdGU6wqDCoCBGcmkgRmViIDE3
IDEwOjIyOjAwIDIwMjMgKzA4MDAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiA+IMKgwqDCoMKgIGJsb2NrOiBmaXgg
c2NhbiBwYXJ0aXRpb24gZm9yIGV4Y2x1c2l2ZWx5IG9wZW4gZGV2aWNlIGFnYWluCj4gCj4gWWVz
LCB0aGFua3MgZm9yIHRoZSByZXBvcnQsIEkgZmlndXJlIG91dCB0aGF0IEkgbWFkZSBhIG1pc3Rh
a2UgaGVyZS4KPiAKPiBGb2xsb3dpbmcgcGF0Y2ggc2hvdWxkIGZpeCB0aGlzIHByb2JsZW06Cj4g
Cj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2dlbmhkLmMgYi9ibG9jay9nZW5oZC5jCj4gaW5kZXggM2Vl
NTU3N2UxNTg2Li4wMmQ5Y2ZiOWUwNzcgMTAwNjQ0Cj4gLS0tIGEvYmxvY2svZ2VuaGQuYwo+ICsr
KyBiL2Jsb2NrL2dlbmhkLmMKPiBAQCAtMzg1LDcgKzM4NSw3IEBAIGludCBkaXNrX3NjYW5fcGFy
dGl0aW9ucyhzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgCj4gZm1vZGVfdCBtb2RlKQo+IMKgwqDCoMKg
wqDCoMKgwqAgaWYgKElTX0VSUihiZGV2KSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXQgPcKgIFBUUl9FUlIoYmRldik7Cj4gwqDCoMKgwqDCoMKgwqDCoCBlbHNlCj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxrZGV2X3B1dChiZGV2LCBtb2RlKTsKPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBibGtkZXZfcHV0KGJkZXYsIG1vZGUgJiB+Rk1PREVf
RVhDTCk7Cj4gCj4gVGhhbmtzLAo+IEt1YWkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiA+IMKgwqDCoMKgIEFzIGV4
cGxhaW5lZCBpbiBjb21taXQgMzYzNjlmNDZlOTE3ICgiYmxvY2s6IERvIG5vdCByZXJlYWQKPiA+
IHBhcnRpdGlvbiB0YWJsZQo+ID4gwqDCoMKgwqAgb24gZXhjbHVzaXZlbHkgb3BlbiBkZXZpY2Ui
KSwgcmVyZWFkIHBhcnRpdGlvbiBvbiB0aGUgZGV2aWNlCj4gPiB0aGF0Cj4gPiBpcwo+ID4gwqDC
oMKgwqAgZXhjbHVzaXZlbHkgb3BlbmVkIGJ5IHNvbWVvbmUgZWxzZSBpcyBwcm9ibGVtYXRpYy4K
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAKPiA+IMKgwqDCoMKgIFRoaXMgcGF0Y2ggd2lsbCBtYWtlIHN1cmUgcGFydGl0
aW9uIHNjYW4gd2lsbCBvbmx5IGJlIHByb2NlZWQKPiA+IGlmCj4gPiBjdXJyZW50Cj4gPiDCoMKg
wqDCoCB0aHJlYWQgb3BlbiB0aGUgZGV2aWNlIGV4Y2x1c2l2ZWx5LCBvciB0aGUgZGV2aWNlIGlz
IG5vdAo+ID4gb3BlbmVkCj4gPiDCoMKgwqDCoCBleGNsdXNpdmVseSwgYW5kIGluIHRoZSBsYXRl
ciBjYXNlLCBvdGhlciBzY2FubmVycyBhbmQKPiA+IGV4Y2x1c2l2ZQo+ID4gb3BlbmVycwo+ID4g
wqDCoMKgwqAgd2lsbCBiZSBibG9ja2VkIHRlbXBvcmFyaWx5IHVudGlsIHBhcnRpdGlvbiBzY2Fu
IGlzIGRvbmUuCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gPiDCoMKgwqDCoCBGaXhlczogMTBjNzBkOTVjMGYyICgi
YmxvY2s6IHJlbW92ZSB0aGUgYmRfb3BlbmVycyBjaGVja3MgaW4KPiA+IGJsa19kcm9wX3BhcnRp
dGlvbnMiKQo+ID4gwqDCoMKgwqAgQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgo+ID4gwqDC
oMKgwqAgU3VnZ2VzdGVkLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pgo+ID4gwqDCoMKgwqAg
U2lnbmVkLW9mZi1ieTogWXUgS3VhaSA8eXVrdWFpM0BodWF3ZWkuY29tPgo+ID4gwqDCoMKgwqAg
UmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+ID4gwqDCoMKgwqAg
TGluazoKPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzAyMTcwMjIyMDAuMzA5Mjk4
Ny0zLXl1a3VhaTFAaHVhd2VpY2xvdWQuY29tCj4gPiDCoCAKPiA+IMKgwqDCoMKgIFNpZ25lZC1v
ZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KPiA+IAo+ID4gCj4gPiAKPiA+IFJl
Z2FyZHMKPiA+IEp1bGlhbgo+ID4gCj4gCgpUaGlzIHBhdGNoIHdvcmtzIGZvciBtZS4gVGhhbmtz
IQpASmVucyBBeGJvZTogV2lsbCB0aGlzIGJlIHBhcnQgb2YgdGhlIG5leHQgNi4zLXJjPwoKUmVn
YXJkcwpKdWxpYW4KCg==
