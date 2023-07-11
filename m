Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC0F74E6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjGKGGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjGKGGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:06:52 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71397D2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:06:51 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R0Vk00XkCz1FDqg;
        Tue, 11 Jul 2023 14:06:16 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 11 Jul 2023 14:06:48 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2507.027;
 Tue, 11 Jul 2023 14:06:48 +0800
From:   "yiyang (D)" <yiyang13@huawei.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Fengtao (fengtao, Euler)" <fengtao40@huawei.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>
Subject: RE: [PATCH RFC] tty: tty_jobctrl: fix pid memleak in
 tty_signal_session_leader()
Thread-Topic: [PATCH RFC] tty: tty_jobctrl: fix pid memleak in
 tty_signal_session_leader()
Thread-Index: AQHZrYT1bMsSMMhC5E+1pp+mQpdZtK+yo7Gg///fOYCAAXasIA==
Date:   Tue, 11 Jul 2023 06:06:48 +0000
Message-ID: <98ca210605f54162a7ff5addd1e86a04@huawei.com>
References: <20230703080323.76548-1-yiyang13@huawei.com>
 <cb540eb6c27f4a71803d094505725ae1@huawei.com>
 <2023071020-raven-maggot-b854@gregkh>
In-Reply-To: <2023071020-raven-maggot-b854@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.164]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIFBpbmcuIEkgYW0gdHJ5aW5nIHRvIGRyYXcgY29tbXVuaXR5J3MgYXR0ZW50aW9u
IHRvIHRoaXMgQlVHIGFuZCBnYXRoZXIgc29tZSBjb21tZW50Lg0KIEFueSBjb21tZW50IHdvdWxk
IGJlIG11Y2ggYXBwcmVjaWF0ZWQuIA0KDQpUaGFua3MsDQpZYW5nDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyBbbWFpbHRvOmdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnXSANClNlbnQ6IDIwMjPE6jfUwjEwyNUgMjE6MjYNClRv
OiB5aXlhbmcgKEQpIDx5aXlhbmcxM0BodWF3ZWkuY29tPg0KQ2M6IGppcmlzbGFieUBrZXJuZWwu
b3JnOyBqYW5uaEBnb29nbGUuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBGZW5n
dGFvIChmZW5ndGFvLCBFdWxlcikgPGZlbmd0YW80MEBodWF3ZWkuY29tPjsgR3VvemlodWEgKFNj
b3R0KSA8Z3VvemlodWFAaHVhd2VpLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDXSB0dHk6
IHR0eV9qb2JjdHJsOiBmaXggcGlkIG1lbWxlYWsgaW4gdHR5X3NpZ25hbF9zZXNzaW9uX2xlYWRl
cigpDQoNCk9uIE1vbiwgSnVsIDEwLCAyMDIzIGF0IDA3OjIzOjU3QU0gKzAwMDAsIHlpeWFuZyAo
RCkgd3JvdGU6DQo+IFBpbmcgDQoNCldoYXQgZG9lcyB0aGlzIG1lYW4/DQoNCg==
