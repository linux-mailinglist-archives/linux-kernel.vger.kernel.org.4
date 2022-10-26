Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5460DEDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiJZK37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJZK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:29:56 -0400
Received: from m136.mail.163.com (m136.mail.163.com [220.181.13.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF9BE3B9AF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 03:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=mkAHU
        sNQX3QO0YeoaDTzg5Q1kAvN901ijdJ8eIctyrY=; b=T2m8eXM0lkVuo6u6AnNjP
        llkUNkgL7oAKNDu3S/SMJZi+GPre71SPmehITdL+53drfd7wQZaOS4nu51qND8Lc
        QGTymFayxicAophjgSkR5Ntd1s1QCNbeMMnh7YEx3qKf9ivMdHiv+a64S2QxODfj
        c1J0cwX8DwGNPE3i1cQl0g=
Received: from 00107082$163.com ( [222.64.157.165] ) by ajax-webmail-wmsvr6
 (Coremail) ; Wed, 26 Oct 2022 18:29:51 +0800 (CST)
X-Originating-IP: [222.64.157.165]
Date:   Wed, 26 Oct 2022 18:29:51 +0800 (CST)
From:   =?UTF-8?B?546L5b+X5by6?= <00107082@163.com>
To:     linux-kernel@vger.kernel.org
Subject: How can I make cgroup cpu quota and task priority work together
 without cpuset?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
X-NTES-SC: AL_QuydBPuTv0ki5yKcZ+kZnEoUjug3W8K5v/kk3Y9VOp80uSnN8xocQlBuAXXqztu1MSOznzeqbTRP7uhVb69UX502mAuIEis4J2zs945ZrjVr
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <42b40adf.4dfd.18413d75a0e.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: BsGowAD3pKwfDFlju05eAA--.59729W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEh+mqmI0Usr7sgAAsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkhpfiEKCgpJIGFtIG5vdCBzdXJlIHdoZXRoZXIgdGhpcyBoYXMgYmVlbiByYWlzZWQgYmVmb3Jl
OgpJIGhhdmUgdHdvIHRhc2tzIHdpdGggZGlmZmVyZW50IHByaW9yaXRpZXMsIGFuZCBJIHNldCB0
aG9zZSB0d28gdGFzayBpbnRvCiBhIGNwdSBjZ3JvdXAgd2l0aCBjcHVfcXVvdGEgZXF1YWwgdG8g
Y3B1X3BlcmlvZCwgaGVuY2UgdGhlIHR3byB0YXNrcyAKd291bGQgb25seSB1c2UgdXAgMSBjcHUg
Y29yZSBhdCBtb3N0LMKgIGFuZCB0aGUgbm9kZSBoYXMgbXVsdGktY29yZXMuCkJ1dCBpdCB0dXJu
IG91dCBjcHUgY2dyb3VwIGRvc2Ugbm90IHRha2UgcHJvY2VzcyBwcmlvcml0eSBpbnRvIApjb25z
aWRlcmF0aW9uLCB3aGF0IEkgZ290IGlzIHRoYXQgd2hlbiB0aGUgdGFzayB3aXRoIGhpZ2hlciBw
cmlvcml0eSAKbmVlZCBjcHUgcmVzb3VyY2VzLCBpdCB3b3VsZCBvbmx5IHRha2UgNTAlIGlmIHRo
ZSB0YXNrIHdpdGggbG93ZXIgCnByaW9yaXR5IGlzIHNjaGVkdWxlZCBvbiBhbm90aGVyIGNwdSwg
d2hpbGUgdGhlIGV4cGVjdGF0aW9uIHdvdWxkIGJlID45MCUuClRoZSBwcm9ibGVtIGNvdWxkIGJl
IHNvbHZlZCBpZiBJIGFzc2lnbiBhIGNwdSBjb3JlIHN0YXRpY2FsbHkgdG8gdGhvc2UgdHdvIHRh
c2tzIHZpYSBjcHVzZXQgY2dyb3VwLi4uLi4KSXMgdGhlcmUgb3RoZXIgc29sdXRpb24gZm9yIHRo
aXM/wqAgCgpJZiB0aG9zZSB0d28gdGFza3Mgd291bGQgYmUgc2NoZWR1bGVkIG9uIHNhbWUgY3B1
IGFueXRpbWUsIG5vdCBuZWNlc3NhcmlseQogb24gdGhlIHNhbWUgY3B1IGR1cmluZyBlYWNoIHNj
aGVkdWxpbmcgcGVyaW9kLCBpdCB3b3VsZCBiZSBlbm91Z2guCkkgdHJpZWQgUFJfU0NIRURfQ09S
RSBwcmN0bCwgYnV0IG5vIGx1Y2suCgoKSSB0aGluayB0aGlzIGlzc3VlIGlzIHR5cGljYWwgd2hl
biBtb3ZpbmcgZnJvbSBWTSB0byBjb250YWluZXIswqAgYW4gQVBJIAppbiBrZXJuZWwgd2hpY2gg
d291bGQgYmluZCBhIGdyb3VwIG9mIHRhc2sgdG9nZXRoZXIgZHVyaW5nIHNjaGVkdWxpbmcgCndv
dWxkIGJlIG5pY2UsIG9yIGJldHRlciBpZiBjcHUgY2dyb3VwIGNvdWxkIHRha2UgcHJpb3JpdHkg
aW50byBhY2NvdW50PwoKCgoKVGhhbmtzCkRhdmlkCg==
