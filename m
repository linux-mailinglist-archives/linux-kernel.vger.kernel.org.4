Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1E63772E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiKXLIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiKXLIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:08:20 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BCD5FB86;
        Thu, 24 Nov 2022 03:08:18 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO7sBmh004512;
        Thu, 24 Nov 2022 05:07:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=HBrqoakNDPs3AB2EWn6R+jG1ozJq4nshKcy70uojhuc=;
 b=bgeqD+L5GhyLZ8VKJyOE6bD3tqBBKAVh64rH+jw3MukhmXnWpZVccafR6ACs4Bc1Mc66
 9hStJsdtgI7jjyaTgt8WgMH2j7uZOJf54hJozmIFN2girYSecLBZUOWmQqlL41nVpRVV
 qdEAe37+TR9/gQpfaTPV2xQvcU9X8xDLUagbrwAMl4MQR6J/616kMc0Hsydp+4p70526
 z67MfQnV/eHV5tLwtCVZlN2heJ/2AI5n9xgVFJ1aEUE2JFTz+e3yiLOytNbHJo0BVqBW
 qiL4VTsNOvw9H0Jr/vnEzUluJRCanaOsQshSV+YeDCaVS5BFU4LdNFKaNfym3TNpkuxp Hg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6x2dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 05:07:24 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 24 Nov
 2022 05:07:22 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 24 Nov 2022 05:07:22 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 496182BA;
        Thu, 24 Nov 2022 11:07:22 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/2] Use ACPI_COMPANION macro to obtain acpi_device in cs35l41_hda
Date:   Thu, 24 Nov 2022 11:07:16 +0000
Message-ID: <20221124110718.3925934-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: icymHGFSQCP9vNta4tdh6ta5bAP9P2DX
X-Proofpoint-GUID: icymHGFSQCP9vNta4tdh6ta5bAP9P2DX
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in cs35l41_hda driver, we use acpi_dev_get_first_match_dev to obtain
the acpi_device used to obtain the properties and gpios.

It is better to use the ACPI_COMPANION macro to do this, since it guarentees
that we get the correct acpi_device for the device.

However, the cs35l41_hda driver uses the serial-multi-instantiate driver to
enumerate, and whilst the ACPI_CONPANION macro works with spi, it does not work
with i2c. This is fixed by setting the fwnode for i2c.

Stefan Binding (2):
  platform/x86: serial-multi-instantiate: Set fwnode for i2c
  ALSA: hda: cs35l41: Use ACPI_COMPANION to read acpi properties

 .../platform/x86/serial-multi-instantiate.c   |  1 +
 sound/pci/hda/cs35l41_hda.c                   | 50 ++++++++-----------
 2 files changed, 22 insertions(+), 29 deletions(-)

-- 
2.34.1

