Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42326EFC76
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjDZV31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbjDZV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:29:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC3C40E8;
        Wed, 26 Apr 2023 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682544536; i=w_armin@gmx.de;
        bh=oufZCIe50wgKuLFQDyobMgjM8pxGO6eD46RTeNyc1co=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MEcVvoC2Z7eVXYp+ULDxvM3CMO897WOcSY8vckUQGvHi35Gh35q0odgwj9eL9hhCj
         FoWSpn6xCb6pptJywqk9qjmHlZN5a6mgXNlJACwyFoGecJkgi0ctSBnfHrt2I3VzzZ
         ohxPQUx1Aaw84qDNppzGoRRPH6sjbjXtgWi7ySxiKrQanRHFnn8BqBeU1dEDAO1Una
         9oEfX4hitelWAvi1qY0KnDnfRpxYMnsXYL7LzAwKom6VVgYzTL+QUEz+ghSwsxG3Xc
         iBaWmlbafNkODWxooQQeRp+vDV+QgsqqOg0eLXvfpkQ3egLmoSPCsREqg4h8dLC20k
         jFyAg3HlB5ZKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MAwbz-1py9QU3EjZ-00BO1I; Wed, 26 Apr 2023 23:28:55 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 0/2] platform/x86: Allow retrieving the number of WMI object instances
Date:   Wed, 26 Apr 2023 23:28:46 +0200
Message-Id: <20230426212848.108562-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UK4stO+HSR03CMHiOIHSzBpN810UxiBA1BOVuHh6Gx67kvtz0t8
 tfLUMcsT0JLww9ZIZHk6HTTtvFBkGKifpLNLwbDYZ5GLVNx7knozxsglYVs+WPSebCT6FJH
 GmGarmFyhmhERzF/O45eNZhEOPPEPjnVD9gzFmwiBcxpt0r4d4s1iztRlOupIts/7F5cqJM
 foXh9Lse7OceSt7RLFrOQ==
UI-OutboundReport: notjunk:1;M01:P0:S7Sq+7hk1j8=;KDfXD1XltpUCKSxe9+J6lqmxvdD
 Ab2uQgeJZyp2/m4FqjTyZo+GlupIj/lKuhN7oF/e829Pm4rv4KMiqVhir6+5HxhwUrqHlpn7n
 dO0QdyqerRpbDb2hUqkv27AUhX2yYXNqiK829oXEXrhdSBsnHe4313DHWQZk4DBmxnWWBbSgb
 m4EUD3N9u6FVfr4y6v9t8hvqW4Tdd73wuK9x+KrCNka7cslgDvRZXgeQLn2+/vETSS1wuzKWz
 fAO+jy+m6W8/jmFSdiSGRFDoAoeHTyw77lL9jB7hnTxNXW47LCnq+Ld15M6SbTFhMubfqDXlq
 CMDQewunZzpvukVBM9iu9bWPodepc36wBYisMuyDSevie1kp9dtFyWB46+nj7EX3iFtAFzxdM
 kXmq5C6UzEogaoMzw8vXN3vhyy3iE09RAxmMHp8bp2GAJRcqxwYWJ3ReIIoKXz7KGR7HQKVGt
 CQKJjyqjfJmyYSOSIj2LZFvGmM13nLQcSPcr2y5Iz4weCd2jm2HxuDEsbaPsc0acf487bjZWQ
 YrA8QGrtaltSAR4MKZ8HwQK4h+3FFpjAMRqLd/xFSMZyCMDwttlb+CbfhP/gCBsMoj7aLMELM
 u1zVLjq7jPbbQk6a/W1NyIC437UekxWSwYVcwwhzXe9PBaEbeeNq9fgzF3CnZYaRaFoUi8RaR
 d2I8Zf/YrByODZ2o6TUK+G3REeauY9baGkwog6aNxbKO/DRGxhzVFp15aDwmgjdz31ojRQrGy
 4TSjbTwt+m7kG1EoeE1LlbQ3lV/a9RNvaylf+KmTbw4otvTHxExZfVLiRM9Rx8jiqSRE+FjIi
 jVe8VIfVZNdiS0BWnQ4ujfTLcmtfj3V4ck0U1LMQ/CxjYv9QVg+Qd01l9JSnt646ZD8J4mjj8
 VCbut1P8qywo95ZDndaly9CYF9ySv0b/hy5cPh1bFfIaEWP7XJNqOk0wk5mQI0oQbHxlMi1q8
 pAuHvRKv6K9BMbcirbZ43e5b57k=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This experimental patch series allows WMI drivers to retrieve
the number of WMI object instances. This functionallity benefits
several current and upcoming WMI drivers, the dell-wmi-sysman driver
is converted to use this new API as an example.

The changes are compile-tested only, the change to the dell-wmi-sysman
driver also needs to be tested on real hardware.

Armin Wolf (2):
  platform/x86: wmi: Allow retrieving the number of WMI object instances
  platform/x86: dell-sysman: Improve instance detection

 .../x86/dell/dell-wmi-sysman/sysman.c         | 15 ++++---
 drivers/platform/x86/wmi.c                    | 40 +++++++++++++++++++
 include/linux/acpi.h                          |  2 +
 include/linux/wmi.h                           |  2 +
 4 files changed, 51 insertions(+), 8 deletions(-)

=2D-
2.30.2

