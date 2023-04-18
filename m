Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E9C6E6FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 01:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjDRXkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 19:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjDRXkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 19:40:00 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E4A1385C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:37:14 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 342D42C053A;
        Wed, 19 Apr 2023 11:37:08 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1681861028;
        bh=SzQiiHYPUR+RgZsSBcwi55KAk1olWQNToXXLoUY6B/M=;
        h=From:To:Cc:Subject:Date:From;
        b=N5RNNuqb7JjdrYoDbCmTRNYj53mwMxwB0SKAI6PxioR9rto0uT+6A8k27zvQEPbxM
         C3cmbhQRLJyJj4t5exRPMsrqhDFqeu7JqcW4LD8syK86o3WRadz6jmdtvbO9Ixh08O
         fykWANBOH3/EsGkZCeCbUbSnGxUq9CjxvxRfrgAEc2O7idO+0CvXaEGxeBnAUi0/Hn
         E5x63FR8Vbe06KZLHbqTJ8OC2U8drEVGpl0Qe6ea8XlpdaRRzhRZnB2YPYwtLTpVc7
         Iugf5wXgwxeJkpIAvlNy94tzZV8L40PNrLKTo3g0g4e98S1Q6cII6mhyJmrWiw/Tdd
         LFjiOA5v1bZKA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B643f29a40000>; Wed, 19 Apr 2023 11:37:08 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 0246313EDC3;
        Wed, 19 Apr 2023 11:37:08 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 05C29283BBF; Wed, 19 Apr 2023 11:37:08 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, manio@skyboo.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/2] hwmon: (adt7475) Handle DT unaware platforms
Date:   Wed, 19 Apr 2023 11:36:54 +1200
Message-Id: <20230418233656.869055-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=VfuJw2h9 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=dKHAf1wccvYA:10 a=ncuk2GtSjpeHEJ13v3AA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses an issue reported by Mariusz and has an additional
cleanup for master. The changes are all updating of_property_read* ->
device_property_read* so it should be a noop for DT aware platforms.

Chris Packham (2):
  hwmon: (adt7475) Use device_property APIs when configuring polarity
  hwmon: (adt7475) Convert to use device_property APIs

 drivers/hwmon/adt7475.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--=20
2.40.0

