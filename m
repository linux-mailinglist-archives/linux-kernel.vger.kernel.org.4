Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B73603345
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJRTTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJRTTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:19:35 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494E413D0D;
        Tue, 18 Oct 2022 12:19:28 -0700 (PDT)
Received: from 104.47.17.113_.trendmicro.com (unknown [172.21.173.179])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 17E02100004D4;
        Tue, 18 Oct 2022 19:19:26 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1666120764.991000
X-TM-MAIL-UUID: 94afbbdd-eb1e-4bcb-a1c8-ffb516cd9c41
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (unknown [104.47.17.113])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id F234B10005E39;
        Tue, 18 Oct 2022 19:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo/Ti0SUtyFOIRwx3V42F1aqvxs1AOF0/iX461Kg7m1rsBGO6BPpSR9KcTL3e3rwiKMnRE1TipSBTvpsYNpnB+wZeZpECy6IKNIm6JI07LVdduLsNnCU8qP31uDOS39nIfimxcaI1A38aNGw7I99TIt9M1bRYOBHa+XbS6+xWGP/xEv4BRfH7SK03KM8sQ7l8Yxm/sSd+oFvUyucS/jI6carP0/gjsN9MyAoEcvnZX02RFWiEb+7nlJqrqTS3lt8JTtrqPPqjMHWd2mDZN/QfenQoXQt7vDkzg7KqtY/+dfJpIjNZZQ0Lgnryb7GR7QCgBR0PEylRDW0icND0ueyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4oPFY3eWWsZZ2Q/nwqF6GKgLXGfQSUCU/hUWKVCcNw=;
 b=R3usbIs9qbCip3528BeNz6tPM935nltg5SvH7xSKT8LW5+hIvoLk2E0HVaYtXdNH2lP2QS6G/xOMgcSPOBggArXHxu8BLY7sO/cX4Rj7RzVQxt4LpedJ9yKEj+09sI+7h1ZlIM9dCCMfalpOc/rgzX6O1uhvUVFHXKgqRUgO8s17z7Og7Me/tZp+iadSAXMB2aOO4CN1lZHgQdwu5ZO4VhTVVm0l3pC14qDbo3hg+Upb8t8MGE8J/IU22n3x4kRB9hfwWUnOiHs6pct/Bt5duYZQ/TpA+pfs+Fg0vdmBp/6V12LBWJICYhjAmgr+bvrSkvMSNqLr1gXjIH7QzxfjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=opensynergy.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Igor Skalkin <Igor.Skalkin@opensynergy.com>
To:     virtualization@lists.linux-foundation.org, luiz.dentz@gmail.com,
        mst@redhat.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>
Subject: [PATCH v3 0/1] virtio_bt: Fix alignment in configuration struct
Date:   Tue, 18 Oct 2022 21:19:10 +0200
Message-Id: <20221018191911.589564-1-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT008:EE_|AS8PR04MB8674:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bbb8b283-4a4d-4f3f-19df-08dab13da9c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SH+p18+g7CwMHAYIygU8b/PJ9iW11Y2a9545vxi0+7jJOc3HXTZJFxH45FyZ8nc/6zyYShYwysdXL/0zDY3uygiFbinR4kOXakoEw6aWiSjrTJmi8bQ6Qd3lmYJARC2IFYd2S4oh9lRlyLS2Jv9yHDSjxYIsx8edlHjDK0fk0enRQMttL/MZodmykSlgXTGcawEAxIbg1RxLOmIZ2Wxf0AXvbW3lbJNbjnsHAb3cT+D8IoWex8i8mlbJkV6coaLHbc+1Zf5Cod3/on2yjUp/+0f2mNOkfDbrywrOfNqOsmVKuleWsGJ7weZMrOhaJvEIbniTe/oiqg/jHlX7no68WTihIHXJyNVObWhZ7fD2TRwrv8XFLZayv9as7nVwF1tSTgBkDMECNcpUqNKV4tORyLokdBZcZLZCKmqBGvp6WmPtRlAsnj3xejt3uOn9qrSwQuTlk7OoJiavzDiQ8bWSnvhWvAoWmTE5hqrpi3kbOPNdFOFo0u4TucnobSl9rsc2Mh3i3RqQa0h8nCzTqLILF2TLYk7qN0vYcEeJO5/KgaE+OuZSF3TxwmNnFILsjk/q/FjJR01YeMvpscm5r3GyRn0ZfgHKUzd20rx3wRMLe+CHBRQnn9Q1Hr3v7xQop43AxvsqKZWGA1Rn4xB/jq0mwYRMctAr3UXYx0jSehZpMMA6dBVyYI3HHS/6G8Hdk5KN8htO+bXt12i2yk3e6zxjv5IV841rC+gFY3WAbBEyA8a632+yXwM1ma2O8a+h5IIGNKovgbj4EE6j7GuKrvvMwvR/s8DoSM7Y7RnVylRhtPw=
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(39840400004)(396003)(376002)(136003)(346002)(451199015)(46966006)(36840700001)(66899015)(36860700001)(41300700001)(83380400001)(47076005)(5660300002)(26005)(40480700001)(8936002)(86362001)(336012)(8676002)(1076003)(70206006)(186003)(2616005)(36756003)(2906002)(4326008)(316002)(966005)(70586007)(81166007)(107886003)(42186006)(478600001)(82310400005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 19:19:22.5396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb8b283-4a4d-4f3f-19df-08dab13da9c7
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT008.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8674
X-TM-AS-ERS: 104.47.17.113-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1006-27210.001
X-TMASE-Result: 10--5.057500-4.000000
X-TMASE-MatchedRID: XnUH3azbhjw4vjIDbvA3OMVUBXy8OM3/M9EkAUzyluGAI7Mvq/sL57ek
        d2LX0DpINaAGdu5Ot0eXJbVmtnHrxnI0shGAc7FenVTWWiNp+v+wQ8dOma+kqnROxyHvZdJs4B9
        I2K2gpO+UgFUWoYCf4+TIxytvTQKsbwiLg6tAv8VDcQUoQp00sE3yuY9BGW8r/NbvBEf2bLnMoA
        Jfsjm0TnLH5w7bl52jQY7/FJpJ6BMvhYHDok+vI9FXCpDlsQuU/jYKd9VlUo6trUfO3IgJ1DFbv
        WeUOC6J41g48FO1l6Yf1dtrKnxm3VTpG8BH9sIbfsrJIMK37At9LQinZ4QefBTJFL84IP3FlR1c
        T9YafQWBkH6ve8DfyeloYgzjonrsOwBXM346/+z3s8ptkHRL2aRvrCUallhdavFqpZhYH0f2vYs
        cjnYCg3fe3hSTBj7A
X-TMASE-XGENCLOUD: 60c33c63-c177-472b-bc35-b6e3cfb400c8-0-0-200-0
X-TM-Deliver-Signature: AE6164293408DDA9A0CAA97220D3D1D5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1666120765;
        bh=lHe78DgowJQfXmRl0AP4RxEtz8Fia+PnsrKyEwAWv1Q=; l=1685;
        h=From:To:Date;
        b=vrCmfEO0e/lbnzB3/Rx32iPerXBCcs1w4oJ2TQszbLnakOhTGSIzrJ7BJdEVYmVst
         IuE6QGWEVWe0ggxxLqLO6WJV2VeSQk6/P7fmQ8rPz4PaE4vfYOgGb7sfZqX6+GzE/a
         zuWSIc7PmaBN09fECuX9hJ6L9VNAUn/kK4V0AAWx/2o4GIj9o7SlgyOPqBNi6BEmSG
         lXr7SRcT909abiwQxZMBfVJKfeHAeVzos1cxDkM+Y6ZH/xAMjCgticCWq7FUDddOhj
         rNOAQOQv7E70ajidoXmZoC/Qvd8HZYMK9DoPKn7PqkFKi47NZ/H/gvFY6yusq6LR3F
         7fa5Bum93AHmQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to specification [1], "For the device-specific configuration
space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
and aligned accesses for 32 and 64 bit wide fields.".

Current version of the configuration structure has non-aligned 16bit
fields.

This patch adds a second, aligned  version of the configuration structure
and a new feature bit indicating that this version is being used.

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf

Changes in v3:
  v2 had been sent from the wrong address, fixed.
Changes in v2:
  The first version of this patch just changed the configuration
  structure in uapi/linux/virtio_bt.h
  This can not be done, because it will break the userspace, so the
  second version offers a less radical approach - it introduces a new
  feature bit and a new configuration structure that both the device
  and the driver will use if this bit is negotiated.

Igor Skalkin (1):
  virtio_bt: Fix alignment in configuration struct

 drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
 include/uapi/linux/virtio_bt.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

--
2.37.2


Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>
