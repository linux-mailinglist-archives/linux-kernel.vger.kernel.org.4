Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04F7715CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjE3LSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjE3LSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:18:47 -0400
X-Greylist: delayed 344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 04:18:45 PDT
Received: from er-systems.de (er-systems.de [IPv6:2a01:4f8:261:3c41::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C6AA0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:18:45 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by er-systems.de (Postfix) with ESMTP id 98791ECDAD2;
        Tue, 30 May 2023 13:12:58 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by er-systems.de (Postfix) with ESMTPS id 81327ECDAC4;
        Tue, 30 May 2023 13:12:58 +0200 (CEST)
Date:   Tue, 30 May 2023 13:12:57 +0200 (CEST)
From:   Thomas Voegtle <tv@lio96.de>
To:     linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Sometimes DVB broken with commit 6769a0b7ee0c3b
Message-ID: <da5382ad-09d6-20ac-0d53-611594b30861@lio96.de>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.103.8/26923/Tue May 30 09:22:21 2023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,


I have the problem that sometimes my DVB card does not initialize 
properly booting Linux 6.4-rc4.
This is not always, maybe in 3 out of 4 attempts.
When this happens somehow you don't see anything special in dmesg, but the 
card just doesn't work.

Reverting this helps:
commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f
Author: Hyunwoo Kim <imv4bel@gmail.com>
Date:   Thu Nov 17 04:59:22 2022 +0000

     media: dvb-core: Fix use-after-free on race condition at dvb_frontend


I have:
03:00.0 Multimedia video controller [0400]: Conexant Systems, Inc. 
CX23887/8
PCIe Broadcast Audio and Video Decoder with 3D Comb [14f1:8880] (rev 04)
         Subsystem: Hauppauge computer works Inc. Device [0070:c138]
         Kernel driver in use: cx23885


zcat /proc/config.gz | grep ^CONFIG_DVB
CONFIG_DVB_CORE=y
CONFIG_DVB_MMAP=y
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
CONFIG_DVB_USB=y
CONFIG_DVB_USB_TTUSB2=y
CONFIG_DVB_M88DS3103=y
CONFIG_DVB_STB0899=y
CONFIG_DVB_STB6100=y
CONFIG_DVB_STV090x=y
CONFIG_DVB_DRXK=y
CONFIG_DVB_SI2165=y
CONFIG_DVB_CX24116=y
CONFIG_DVB_CX24117=y
CONFIG_DVB_DS3000=y
CONFIG_DVB_STV0299=y
CONFIG_DVB_STV0900=y
CONFIG_DVB_STV6110=y
CONFIG_DVB_TDA10071=y
CONFIG_DVB_TDA10086=y
CONFIG_DVB_TDA8261=y
CONFIG_DVB_TDA826X=y
CONFIG_DVB_TS2020=y
CONFIG_DVB_TUA6100=y
CONFIG_DVB_DIB7000P=y
CONFIG_DVB_SI2168=y
CONFIG_DVB_STV0367=y
CONFIG_DVB_TDA10048=y
CONFIG_DVB_TDA1004X=y
CONFIG_DVB_ZL10353=y
CONFIG_DVB_TDA10021=y
CONFIG_DVB_TDA10023=y
CONFIG_DVB_LGDT330X=y
CONFIG_DVB_S5H1409=y
CONFIG_DVB_S5H1411=y
CONFIG_DVB_MB86A20S=y
CONFIG_DVB_PLL=y
CONFIG_DVB_TUNER_DIB0070=y
CONFIG_DVB_A8293=y
CONFIG_DVB_LNBP21=y


