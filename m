Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633FB6CC223
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjC1OfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjC1OfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:35:10 -0400
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2092.outbound.protection.outlook.com [40.107.23.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1774233
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFm3lBwbJ44sOTRg6r6Kjr60ELRDTwHR4kAlDw74J6U=;
 b=SCqWNteJxKCKeVSnq7UFaSC61ED47eVfUZfntSIAvj3U8mimLoeNKEcbIFLaVZKXPVwxbtKziiEYS7c/I0HrJrlC0igAWFxQ5ZeznkYsnN9IDebNTT5KlfI3ASwmWBIshRsDpv6NN3Po0/HJweIB+FqqVEf16fzTBKKD7uSCHsY=
Received: from DUZPR01CA0255.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::27) by ZRAP278MB0964.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:48::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 14:35:07 +0000
Received: from DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:4b5:cafe::1e) by DUZPR01CA0255.outlook.office365.com
 (2603:10a6:10:4b5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 14:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB5EUR01FT026.mail.protection.outlook.com (10.152.5.2) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Tue, 28 Mar 2023 14:35:06 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.112) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 28 Mar 2023 14:35:04 +0000
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=UovnutyGDDadjsQ5j8coEgitB4BMR+YjtMO3NPf1rhj3H27HWQQvGhN+oL3qtEvgH9IIA//YA3O/a6M5JSodXjNwhNIxLxA4c1VdMIsHSYBA2PXkCinX3KOm03RBEhZNgdHQkfOzzzX+E3Z7qwvov7vDK2RHuisDDN1Z6lWqQmtjYNayUo1YfrSPrCktnkgpyK7NZHySwBAmkcSakAnV/HfJOfKC5pkCNiyeatF8EgB0c9PgGn7FU4XPcECdShfamRRrL672iAUvywknewLYybPzMB+/mfOILuOtvDt49I3brnityQLz7ua2IMEgwTZXWXhWrOFsW9YL+vQeQ9J16g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFm3lBwbJ44sOTRg6r6Kjr60ELRDTwHR4kAlDw74J6U=;
 b=eygsZ35Vxom510Mydw0Xsbd3UG+kVUYtiis/hC4NAlxQgJPNI1gkfDnTjNYLGSkwInoE4opljotO4HRTgmw96KsEf6zigZ78N64/GMLnr8/6A7Bo7O3jsanQLU6D+u64WXLDfS10BiHsltm9PC6ASj8DGz6lD4BkUX8QyXGYinXktrH8IG0zq4TTa6rMLql2kbmbqF8241XbvQdqNoHryL1FQfJCQmryxNhKjTBEy+lA/gR3sfeEArV0DrblZIyJaBU4+6wdkXR8b/ftlOvgrgpa1KEjStKIvsvU3VBIreV9Ub68qQCRis9vJLFZTaC+KSHrA9ynoEXMyrAKdxSarg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 104.47.22.112) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFm3lBwbJ44sOTRg6r6Kjr60ELRDTwHR4kAlDw74J6U=;
 b=SCqWNteJxKCKeVSnq7UFaSC61ED47eVfUZfntSIAvj3U8mimLoeNKEcbIFLaVZKXPVwxbtKziiEYS7c/I0HrJrlC0igAWFxQ5ZeznkYsnN9IDebNTT5KlfI3ASwmWBIshRsDpv6NN3Po0/HJweIB+FqqVEf16fzTBKKD7uSCHsY=
Received: from FR0P281CA0110.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a8::6) by
 ZR1P278MB1085.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.33; Tue, 28 Mar 2023 14:35:03 +0000
Received: from VE1EUR01FT104.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a8:cafe::18) by FR0P281CA0110.outlook.office365.com
 (2603:10a6:d10:a8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Tue, 28 Mar 2023 14:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.47.22.112)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 104.47.22.112 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.47.22.112; helo=CHE01-ZR0-obe.outbound.protection.outlook.com;
 pr=C
Received: from securemail.duagon.com (91.135.65.126) by
 VE1EUR01FT104.mail.protection.outlook.com (10.152.3.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Tue, 28 Mar 2023 14:35:02 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by securemail.duagon.com (Postfix) with ESMTPS;
        Tue, 28 Mar 2023 16:35:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zdtr+3zqqFSZd7Z1B0ZtV2rY4ghF3grprSi7vTt6TNTL2VhBtVGJ4A/6dcaRiZJelvW2FfTK9CXPusRtevfS19ahg0vd/PKyuMN2PFk02L+AexZnglNKEF848nmdRR8zqds5KyO0LFwX2SzcRQMRGCuPPgkB09GB9ooFL19v7qVZqcwBGkLOSdBgf+o0UDteAfLLi4tozP+VuR6/Vw5/HjtK4E76QXEWhtr3+WgclDAFar8+aCZyD82V/Wsi4G6EtrI+QvV7o8ILYmbyAB6yAlIgDdMdi1uEGptDMdV1bDxvkQdSGho3UhHxrFdju7ictQwALF/VBZncT1u6krOzhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFm3lBwbJ44sOTRg6r6Kjr60ELRDTwHR4kAlDw74J6U=;
 b=NFhSHrFYxmbcZQCKCVxcKXkJt9vlegmPkvkKgkvuhnO1kFv5nTmVi3f9UYNuHNmzVHm0lMimrkZixePOI0zgzxR90c5KTxOlW3jHDFKNl2izqEU0sCq81m5XvLzoM0xCl7UP2WNdyRG6x1bMGQoyFS07XGXlY84hYM3W5LO0U1KOjj3HDmO3LvQ4KsXPXzkbD5gIXHCzBF9Z1ngev7E25afTHSx8ZrrBu+OkL8cKcV8DgwzfBbiW9yftMGUdzbY8o9K7kVgtuwfDazxC3lJN4TOiwS1QJ4GI4XBvX+cLOOONLDJFWTzpeYyvDYkGRuRy8skIO338sOJihNeNEvK/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFm3lBwbJ44sOTRg6r6Kjr60ELRDTwHR4kAlDw74J6U=;
 b=SCqWNteJxKCKeVSnq7UFaSC61ED47eVfUZfntSIAvj3U8mimLoeNKEcbIFLaVZKXPVwxbtKziiEYS7c/I0HrJrlC0igAWFxQ5ZeznkYsnN9IDebNTT5KlfI3ASwmWBIshRsDpv6NN3Po0/HJweIB+FqqVEf16fzTBKKD7uSCHsY=
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::13)
 by ZR0P278MB0800.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 14:35:00 +0000
Received: from GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded]) by GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM
 ([fe80::96b8:de96:db9:cded%7]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 14:35:00 +0000
From:   =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
To:     "morbidrsa@gmail.com" <morbidrsa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jth@kernel.org" <jth@kernel.org>,
        =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= 
        <Jorge.SanjuanGarcia@duagon.com>,
        =?iso-8859-1?Q?Rodr=EDguez_Barbarin=2C_Jos=E9_Javier?= 
        <JoseJavier.Rodriguez@duagon.com>
Subject: [PATCH v2 2/3] mcb-pci: Reallocate memory region to avoid memory
 overlapping
Thread-Topic: [PATCH v2 2/3] mcb-pci: Reallocate memory region to avoid memory
 overlapping
Thread-Index: AQHZYYJ5zh/xe/6i+UqkzYOSlWwywA==
Date:   Tue, 28 Mar 2023 14:35:00 +0000
Message-ID: <20230328143441.78932-3-josejavier.rodriguez@duagon.com>
References: <20230328143441.78932-1-josejavier.rodriguez@duagon.com>
In-Reply-To: <20230328143441.78932-1-josejavier.rodriguez@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic: GV0P278MB0996:EE_|ZR0P278MB0800:EE_|VE1EUR01FT104:EE_|ZR1P278MB1085:EE_|DB5EUR01FT026:EE_|ZRAP278MB0964:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6262dc-7302-4a4b-241b-08db2f999ff0
x-seppmail-processed: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: JSpNXAv7FFZjxJMe4YUMcSYX7yKp9LxNWtZaCa6Z3klffm2KAXIcN5vpHF2s5+YrGE/UkLjmFzW1u6KSIRXI29EeTjEJ8PMco7rjW+Yh6Io0r+qHbVh67o3aW8AVQ0UAOD1qXP1ktc2fvllMAeOGY0sYkOweKui3Pgzk2alGZQ2pcuCyWKOiLGb+ZZ/V4JWBhqKvcdMYahEPwE0/pDFH4wo1AK+g7Cr+jLbmzh9HDTxnhFoYKZvM1zL2r/9ZehBfHyh8lvFu7JTObWfRQtVfy5k8YFeLWI8J9M6lNWTRCBZFx9MG5e/+erEZf/xgUzKGZn4A5gSK6I/MfZr5lzhVKzhnOEX7RLY6TdVaGmfpZ7/xnEUlV0bTHMJizRsmROXRdlZyPRGNHYxKcTYXX4iItmEpaFJ/gd76FeBpTRCShoDA7deIj2m1WJKihFDoLkDdFWk/3HCrHeW8v8mOEMNI+PPbTIHmIiM0jnxx9BDYI39yl555AN3PWSUMRjNc3GyRUKqVsCqamvSZslMDQtqvNUoMxC1I8YgZHe8nRDDPzWGUgsv8EERLPWsbA2K4f11t4HLc+OrcxYY2SZt7BTSW9UsmH+J9Fulig8xotyQiB9MDaOw27yGopzoS0BWkgssU
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0996.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39850400004)(366004)(136003)(396003)(451199021)(107886003)(41300700001)(122000001)(91956017)(76116006)(66946007)(66476007)(4326008)(64756008)(66556008)(66446008)(86362001)(478600001)(316002)(71200400001)(54906003)(110136005)(36756003)(38100700002)(38070700005)(8676002)(6486002)(2906002)(186003)(26005)(83380400001)(5660300002)(6512007)(2616005)(6506007)(1076003)(8936002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0800
X-SM-outgoing: yes
X-EOPAttributedMessage: 1
X-MS-Exchange-SkipListedInternetSender: ip=[104.47.22.112];domain=CHE01-ZR0-obe.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT104.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: b1289da3-6ff2-40d2-1f32-08db2f999c71
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: oLt+/VmRpM1MbGlDotMsNy5Oo14uUWXzkcnWniA4JLRwBH3HK6K7kk3Ghrz1SCH0ZFrmH7mJ6JnsGLYYcY7Dsu9d858TTMn3OLsMMjSeO2YP4QdiGxD6uM2bl2N/8724X4cvNbg93FOSSDwNlcjZ1HqacTdLEiIOyBZZoVTZORp/yd8aTWm9k3ClE40/NxVkYZlPldbhnXsGngt+c899y2pfcSaPqcKWJLvKEwdA4KyTr1LF1Pwd725OW0ssKNe4TILqCRwn+H7oO17KIYZIhoqfIT45i48V+iWKQomsEwby9cb/RGwjaph1QfSKLTmxTIM++RwTF0D+uQCMhN6nllBs7DcLAGhPLNnR6hGyNIbTr5mosC46gZDj1vi+TFjTm5elU+y0YhM598/CpFgmTphg9mZ0e2V6zvlGjwIHk9xrNEOfDFtixHL7l4VBDnDw9s9J6EstkQXVzGT5l8Vz0uvSqeM7+YXDKwkvObVaSRhtTgHYhLz1GTNh+Kfo2eQSvvM0/sbD4Rj/kWgIle0hKpcLCVG6DNZaTPv5JTALTjPOTE4CjI5u9sExBvp+hJEB/MpsPfmsGGMdxGH5C+Nq0xtIcHk1r7G9AUzDGP8yRMxEivC5k+fwl5277mHVcs7OERuIDCKc0Ef+4sucg/GKW+PclIS2AZFFIuDTYwmuH4s/b+8P4FQTHNUTX+lj2zlFwH7RfefqOySaagIBi66eYNpHfBlIAfDEFVQXH95763LRvEWuWR1URBLYi2jdvoUuhXf8dcQdkDNyq0OvTcT4lRtiGRcfVVwcAL0lc7p+7dNsWhJRcVz4I4gT+MSK4yklnadilptVy3awp7ocJYRmTQ==
X-Forefront-Antispam-Report-Untrusted: CIP:91.135.65.126;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHE01-ZR0-obe.outbound.protection.outlook.com;PTR:mail-zr0che01lp2112.outbound.protection.outlook.com;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(39850400004)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(478600001)(86362001)(107886003)(6486002)(36860700001)(54906003)(316002)(110136005)(82740400003)(7636003)(5660300002)(8676002)(4326008)(70206006)(70586007)(32850700003)(156005)(8936002)(40480700001)(47076005)(186003)(36756003)(6506007)(41300700001)(6512007)(82310400005)(26005)(1076003)(336012)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1085
X-CodeTwo-MessageID: 176e49f5-6a86-4873-add3-d589266b91fc.20230328143504@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9807751c-3dc5-4f2a-6ea9-08db2f999e28
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aot0edJ6Omkj4DXpkvVVnTNNQCUyChdw8o779IF4uRh5jOx8Av9upQ7nMLLS7NSXXGh7TjtqcTEVaNjzd9yi6rUwt9WJC1hdDyVEknfK0Mw2TMKWDpKupeAkIHWohUv89ttQhUWxs84gYhbtFMqyR+Lhx/yLrPwCClXZ86BxIc38z3UtJJTyVWXvFKOEf3xSN1h7hoFzVEA1wWis79UdFLWLv+3X9VK5r1NstbdXSmzpFy5IrcdwfjSljzOB56WKHOl+NncSKd8fDrtTGhtrVjgbV7CCkr9/mbgKqkh1Tni96V9sdEhg9kY8qHwwY1xMGDAf+u6870FmnuzQAl12jC1W60m+UIFQUsxQvEKFvHjBETTG64+M0sfgvmoeFDu8fDJd9ERl16RBzhkUpiJ7uawz/0jl60peMV9UGJooHl1vjZGCCAZQVVrq7p7ZH5L5TG6GVoE27kVO70tWmIjsXQbC/e/vXnxOXQRA+y/yzpKofCJ7fCdmO+6U1wB9q2/R7tiSnM/wSmK230EdhZlufpW9Dhss4CbtiCvtJdzGf4MFynh8F4wYMVYvUtDrpcG1XDj1SRZ+nQNN+jl4xAoAFKEDVwsCHvUquCRDqLN+Ueuw+lg8qPK4WEjI6yKR98nCpHZ2GyHBBwbXEtPGgLh3yFcrhdaZy3FNOhMbxBE+W8s=
X-Forefront-Antispam-Report: CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(136003)(39850400004)(346002)(396003)(376002)(451199021)(36840700001)(46966006)(2906002)(86362001)(40480700001)(36756003)(82310400005)(6486002)(478600001)(2616005)(107886003)(83380400001)(336012)(47076005)(54906003)(70586007)(70206006)(8676002)(36860700001)(4326008)(6512007)(316002)(26005)(6506007)(7636003)(1076003)(82740400003)(186003)(110136005)(5660300002)(8936002)(41300700001)(7596003);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 14:35:06.1696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6262dc-7302-4a4b-241b-08db2f999ff0
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0964
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mcb-pci requests a fixed-size memory region to parse the chameleon
table, however, if the chameleon table is smaller that the allocated
region, it could overlap with the IP Cores' memory regions.

After parsing the chameleon table, drop/reallocate the memory region
with the actual chameleon table size.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 drivers/mcb/mcb-pci.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index dc88232d9af8..53d9202ff9a7 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -31,7 +31,7 @@ static int mcb_pci_probe(struct pci_dev *pdev, const stru=
ct pci_device_id *id)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret;
+	int ret, table_size;
 	unsigned long flags;
=20
 	priv =3D devm_kzalloc(&pdev->dev, sizeof(struct priv), GFP_KERNEL);
@@ -90,7 +90,30 @@ static int mcb_pci_probe(struct pci_dev *pdev, const str=
uct pci_device_id *id)
 	if (ret < 0)
 		goto out_mcb_bus;
=20
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size =3D ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mapbase, CHAM_HEADER_SIZE);
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res =3D devm_request_mem_region(&pdev->dev, priv->mapbase,
+						table_size,
+						KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret =3D -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base =3D devm_ioremap(&pdev->dev, priv->mapbase, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret =3D -ENOMEM;
+			goto out_mcb_bus;
+		}
+	}
=20
 	mcb_bus_add_devices(priv->bus);
=20
--=20
2.34.1
