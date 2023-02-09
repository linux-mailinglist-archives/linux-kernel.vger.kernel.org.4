Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B4A690891
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBIMW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBIMWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:22:24 -0500
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65321125A8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:22:23 -0800 (PST)
Received: from 104.47.17.172_.trendmicro.com (unknown [172.21.19.51])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 0F62410237626
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 12:00:57 +0000 (UTC)
Received: from 104.47.17.172_.trendmicro.com (unknown [172.21.191.62])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id AB7D310000C5F;
        Thu,  9 Feb 2023 12:00:39 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1675944036.950000
X-TM-MAIL-UUID: 91bccc04-e651-4047-b4d7-0445c28fc6f2
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.172])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id E8393100003AE;
        Thu,  9 Feb 2023 12:00:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US+KPmOV5NwaJPiTeJ3EEf60bLR1tGmpWYNpdsgNNMMdwZ4zcl2/zw01bKKd6r8V+Y+J3OlBX/jMoHn9erwtRiTfQ+lWEARl578IRaQN4PNfddkHwFg/SSqFfzKGyy2KLMrHD70dPd1A+tmLjb4iEMNakytONxi7ZxgmrRJQEJ5595yy6c47as/hcrZbF9m05edcv+fhcoxn7iS5N6HRzP3SFdI5lY2cC0MgVw2G2CX101ryYpJgaIDE01Tc4iNBUnfOnVppZNXkger8Pg6AhKhNmRY5i8iEQrnOGmfMsVebQ0Cwaipa5L+OZhvTxKtw0bTj2akdg7Xv4g1HHlpbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZ02oTACz2KcVlvqyYQqq224B+q7XX5jKoyPuhODcXk=;
 b=ZLp+IgfGn3tBWAUqM0YZV2MyAveUpfIATxBrPOPk49/W5/H/Aa5DVHmZ/KmG1CZaBf9XOZ3yrsfqmdULrl97hkGxvJXPVQjS5V9jaBgNy9HhNY0YyIbzg8r++HT3E+xmTLWDvrlKk3sqEroJuDEwtzUU5lqA98F+6c8+0FaqfPaM1bQN0qiUqdTUKD8evWMXr3AcHF6GTp4FQzuveuL14MeV8Xv0vuFlAgpOBO6anJN4A17uK+mM7peUHTXnl9QTDt4M4aqmPKIDUR5r06gAajDdIE46E5am/GSNN989jGC+i6Ublk4+NtZJki+lUUkH6baQCq/JluaBZBt08tgEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensynergy.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=opensynergy.com; dkim=none (message not signed);
 arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
To:     mst@redhat.com, jasowang@redhat.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     Anton Yakovlev <anton.yakovlev@opensynergy.com>
Subject: [RESEND PATCH 0/1] ALSA: virtio: add support for audio controls
Date:   Thu,  9 Feb 2023 12:59:15 +0100
Message-Id: <20230209115916.917569-1-aiswarya.cyriac@opensynergy.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT032:EE_|FR3P281MB1613:EE_
X-MS-Office365-Filtering-Correlation-Id: a5865f2c-05dd-4726-4538-08db0a953fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYiVtna5hdSXuwxzqNDaveEgbGU7/28VMkZLFjZ1xhQmVBlOrJ5NKvDMQrHtkFxt7WC0YKcPDVjC1x0kscxJ9tY/2D1VW2tLV3IgHF3v1uzxmRcCn9GQ2oa4VOhfdhrUlB64AmirklHcYkozWGm9TGuHlH1jKlJCvUqFG2eaLVNGiwyIdOT7mYxT9OM09oTo1zBSBWO2D7dYiqczBgHUV1f+sW/9V21DWxO0oT0Eie1ZINiTTW+bXpr5KbULPljbTi9JXmGqsElcImuCHf1uhySxUg7Iyyy/O6mundRd137GE3KZykkx6hisVcCL7Aey7b+tO6AqF4UyxAfPADSbYxpBZORAzY2BzjVch7xUobBa7SEA0Tlpu2BUTVpji2GtjoqAIXaXBsBEre8JnOwQbrdOV4/qJZ8Y82zfRb4UGC2SeuvgTw8FuD6PDJgs2XQ98E2MqeD85oxtlJv5Fk6M1IlogG+MoahE/YrXUoT2opbzyNIBIr5P7Y0JcsyDkuJWj+4SNOpERA9Q5kboeTEKtPC4gXNi2WaZOS9PDYw4Et7UFZHICvMYNXnNxNPM4hwTbOsAqwZAXhqaqcplXZktZ7/r+55LmAkBXPpZpj878fQ89S0nEpevE0EjM8L8RihQ0tDJacwggvybKfZpURzqtRhmBKm0fpH5vukzdFXkxUlCSHMjI61VNWmFiDQ+5H5DPL6E7HTQZbGH+YTlAUAW1zHN0TUTW1aSm1rh4AzskQY=
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(39840400004)(346002)(376002)(136003)(396003)(451199018)(36840700001)(46966006)(86362001)(36756003)(81166007)(36860700001)(186003)(70206006)(8936002)(41300700001)(42186006)(316002)(70586007)(5660300002)(4326008)(8676002)(82310400005)(40480700001)(44832011)(2906002)(966005)(336012)(478600001)(47076005)(2616005)(107886003)(1076003)(26005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 12:00:34.0711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5865f2c-05dd-4726-4538-08db0a953fe8
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT032.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1613
X-TM-AS-ERS: 104.47.17.172-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27436.006
X-TMASE-Result: 10--2.278700-4.000000
X-TMASE-MatchedRID: I6rpFm0lrcP5S+IvXI7mDfIq3+8DQd0oRpgtqnD1BD7+a1TrNm8OEcTv
        CDkkT7+sVlW1V3SVSFT58HP6T5es/o+eiI05y0fp7pujb8urdzawQ8dOma+kqkmtW7dN/qcX76d
        4tCBY3uWYL7Af4qgNyrwc7WEBS4b7WWj2fZGMdP9+yskgwrfsC30tCKdnhB58FMkUvzgg/cWX0L
        n1to6aTkazPf1QyU1JjoczmuoPCq1RmM/kpAuKCvWCXnU6ITIJHFSvLlz2EMjN8WnBKlB3Gtosd
        I0E3fVu
X-TMASE-XGENCLOUD: 20d5ccd3-51b8-4965-8f4b-a5919edc87aa-0-0-200-0
X-TM-Deliver-Signature: 99970238E759D8410FE01175CF601E5D
X-TM-Addin-Auth: FYEoRHqsW7qiPPOA2CqAkSB3yzlybqZil5u9J228xJqlo5ViyBB7S1w+XU3
        0hd1N/+hKruaw3/A8ZvFOEKLgT03xYTSP4XyYX+jMkCUqUfd5DCwKb/2DZOpqfdXrvTmAqK1PV3
        dG0c7B1pJmWlkBQUJCMairN5BmQUmhRbNhCNE5hbyuJw0n4uoS/vYwK9UuvU+zyVDnEhz3gSWdl
        TROsicjuHqMz7gWTU/1UpDVSScPl+TxJjjkd8g4Ltxjx5ETFR50zz61sq/X5jhv+Spuhzht/grR
        G1XxxGhY6Fa+lA+ozWew2Npzhq85nP3moi0y.WG1v7treR4i4ZRLh69dhY6no4Bg0bGpcEjHlSv
        HsDwyo9Y+AW0tB8Kt3B6KVm02u77DIUtLdltwZMZBt5iqEd0O+5qUk7BmGCuICzUJJOn07i/XaO
        tL1qmzCuvcIKgwr9FuPoH/u3E5k84wQJ2A/Zaa9V0i+hcPLbdPnEMeWa3Tht0P1areCI0VjRj7/
        eGpUdOBoOd0Oszl06htjWF14lObxhMwVuu8CCXr3v3lNgaDy+Svu/kTeE0ziSeDeUOVvXDbSeWN
        zxqFK2006723E1lIidV/TKdFOel5Xh2//HUNsmlwP9EA8YUHHwKGY9SlSqsl/s5qARDol8vDVE+
        tKtg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1675944039;
        bh=Muq29iKv1HAF3XiA6W8PkRgH+kHNvsjX6nbJMnZhvUY=; l=1112;
        h=From:To:Date;
        b=gAf3TBFX9zCRgQpm6N2K248pznB33k1Gg3SVBJCo/hmWMjCti6X9AkQx3Hi/Su5LN
         qTKd//wIQ+AobsR/FuLXAlg3Uv4fNCuW2GtrwVH1oK9HLoGipX63HrpxyJGTnC+U/b
         kL5rmZSNyLIcoH1vsQsHD3TyuDiVTZqcVPwO5GtPyTCth3/bQBPqgCY4AghU01ZFAf
         x0vA/yV7Uc3koISI7K+GWt4reIrTba/tloTiRP3oUM8zDnWnDx4Az4gdoTCNib6/3I
         SCK8SGW3JQ5Vf5/PMy294wfZFPjdQYKpFAXqaMsCU4VMQItFpV3kE1CojFRLMA/3yk
         8qjdRo1uKTzHg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Yakovlev <anton.yakovlev@opensynergy.com>

Implementation of support for audio controls in accordance with the
extension of the virtio sound device specification[1] planned for
virtio-v1.3-cs01.

Design　of virtual audio controls is based on and derived from ALSA
audio controls. It allows the driver to perform all standard operations,
such as reading and writing audio control value, as well as working with
metadata (represented in the TLV form).

The driver part was tested on top of the Linux 5.10 kernel.

As a device part was used OpenSynergy proprietary implementation.

[1] https://lists.oasis-open.org/archives/virtio-comment/202104/msg00013.html

Anton Yakovlev (1):
  ALSA: virtio: add support for audio controls

 include/uapi/linux/virtio_snd.h | 154 +++++++++++
 sound/virtio/Makefile           |   1 +
 sound/virtio/virtio_card.c      |  21 ++
 sound/virtio/virtio_card.h      |  22 ++
 sound/virtio/virtio_kctl.c      | 464 ++++++++++++++++++++++++++++++++
 5 files changed, 662 insertions(+)
 create mode 100644 sound/virtio/virtio_kctl.c

-- 
2.25.1

