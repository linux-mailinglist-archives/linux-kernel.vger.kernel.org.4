Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B461246E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 18:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJ2QYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 12:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ2QYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 12:24:23 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9969AE7A;
        Sat, 29 Oct 2022 09:24:22 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 30 Oct
 2022 00:19:42 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.81]
Date:   Sun, 30 Oct 2022 00:19:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wangkailong@jari.cn
To:     njavali@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: replace ternary operator with max()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7ce8e1aa.43.184248abc71.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3C+KeUl1juOMAAA--.21W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAOB2FEYx0BLQADs8
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgY29jY2ljaGVjayB3YXJuaW5nOgoKZHJpdmVycy9zY3NpL3FsYTJ4
eHgvcWxhX2RiZy5jOjY4OTogV0FSTklORyBvcHBvcnR1bml0eSBmb3IgbWF4KCkKClNpZ25lZC1v
ZmYtYnk6IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBkcml2ZXJzL3Nj
c2kvcWxhMnh4eC9xbGFfZGJnLmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3Fs
YV9kYmcuYyBiL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9kYmcuYwppbmRleCBkN2U4NDU0MzA0
Y2UuLjY4Y2U0NDBiZDZjZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX2Ri
Zy5jCisrKyBiL2RyaXZlcnMvc2NzaS9xbGEyeHh4L3FsYV9kYmcuYwpAQCAtNjg2LDggKzY4Niw3
IEBAIHFsYTI1eHhfY29weV9tcShzdHJ1Y3QgcWxhX2h3X2RhdGEgKmhhLCB2b2lkICpwdHIsIF9f
YmUzMiAqKmxhc3RfY2hhaW4pCiAJbXEtPnR5cGUgPSBodG9ubChEVU1QX0NIQUlOX01RKTsKIAlt
cS0+Y2hhaW5fc2l6ZSA9IGh0b25sKHNpemVvZihzdHJ1Y3QgcWxhMnh4eF9tcV9jaGFpbikpOwog
Ci0JcXVlX2NudCA9IGhhLT5tYXhfcmVxX3F1ZXVlcyA+IGhhLT5tYXhfcnNwX3F1ZXVlcyA/Ci0J
CWhhLT5tYXhfcmVxX3F1ZXVlcyA6IGhhLT5tYXhfcnNwX3F1ZXVlczsKKwlxdWVfY250ID0gbWF4
KGhhLT5tYXhfcmVxX3F1ZXVlcywgaGEtPm1heF9yc3BfcXVldWVzKTsKIAltcS0+Y291bnQgPSBo
dG9ubChxdWVfY250KTsKIAlmb3IgKGNudCA9IDA7IGNudCA8IHF1ZV9jbnQ7IGNudCsrKSB7CiAJ
CXJlZyA9IElTUF9RVUVfUkVHKGhhLCBjbnQpOwotLSAKMi4yNS4xCg==
