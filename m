Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2861D5ED7D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbiI1IcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiI1IcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:32:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3643E895CC;
        Wed, 28 Sep 2022 01:32:08 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=iVDwA+5Y2uTxTRF95K87irnbwhZ3IPd3OGDuKx1/qkEa4nI8nCs1YHYh6vBSa9XB5bSPRR8bzwxb0irg8Ldcno4Gv3TYKl+VRSKG2hzpPxlZxX0aiTghJnJzHnWAFVENszkrlxOlJ8zi7M8nnnZs2E68wit5qzRLtQBSOgoyWCIvv8nNDjtEXQmOrpreP5VCxYzzJymcFmfF0vatF+7ahNYR0eE0isCxPx3HII+q9B8cziPCpWXVaWkQYbGwCE+SHO+2l8hATp8GCoGT+A95hql8heQl9jbCip/6IN0hV5UQMPrab/cH6rUP5JsTSCQUaMnb1a4dJhQaclM1B0qy+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLmNAV9UVIWJOsUKxpqrYQjU5/MJMCaxXtLsBy32TVQ=;
 b=lmn4v8gTpgS/twf4EPPH6S/OK7UHwbhf66PKllA6wJ3Ar+qA7WERcEZxDrgtI39bVKfV5BoP70mny+3YIYEnKZOmZ7LjoEXu33VievV3q2LQNosNFIjleljkjW/b7QK1hDa2EkGLYsqxgvuHBE4DzqWcWhComX7jk231RrALhBb0rcX+aoVLcz/l/fBLZJvQiUZVkV9HvOIRC76OOx+4c/xunsd34KDbNCoSBD4E+ROYRNpkJXI/hr/x0UHKWgLfOBetzPkemnw7F/iozUykvAdf9DroudJlHPrEozM/c27k9owvfHlvDBc1H/Mi70kW8Mg1W0EdSzURgfnxb9K2EA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLmNAV9UVIWJOsUKxpqrYQjU5/MJMCaxXtLsBy32TVQ=;
 b=QPTdbE87XYNquL+MmeNjzn99kpST7Scco2BBHjaVgLtoTZrJeqbWMrR7uMBkjFRnlMdC8MQ3VRVOTKZpDlliy0wPZYFfG5iPTD9YAmluCw0JdlUE/xnqFJ9pfz9OEVz64cWv/Z7m2t4kr2rGC+2qma4gMLeex+jONHlMjYjRDE4=
Received: from AM6PR10CA0021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::34)
 by AS1PR08MB7610.eurprd08.prod.outlook.com (2603:10a6:20b:475::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 08:32:03 +0000
Received: from AM7EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:89:cafe::86) by AM6PR10CA0021.outlook.office365.com
 (2603:10a6:209:89::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 08:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT018.mail.protection.outlook.com (100.127.140.97) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Wed, 28 Sep 2022 08:32:01 +0000
Received: ("Tessian outbound c2c2da38ad67:v128"); Wed, 28 Sep 2022 08:32:01 +0000
X-CR-MTA-TID: 64aa7808
Received: from 930896290dad.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C747B4F4-DCA2-43ED-8386-E298E63AE711.1;
        Wed, 28 Sep 2022 08:31:51 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 930896290dad.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 28 Sep 2022 08:31:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXPbVyWHMwpdG8ZfZaEDO8w8DPL76D2GFDHKtC90VVw4GTfR0rmGRj0eF0FkK6KCfKLCt0Qiwv07Pdfip5R9jhHSQHxgEGgSRBkZWLMLpfEU2jdHftzUkXW/clcKLGrDHWCIie8yEdn3WSW3SIXVTrexMJ4T5Rwe9PXdCu0bhoXW7xyvlzhdAlWRMmj4+W+ldJRBLLv3I4x0ZHOf960ARYiVM/ITHXUVfMpQUuV51MBLRzxu3iQXi5Y5BD8VzjZy2rk0eSiLttFM3K0JD+06w1EIrBiSrp3L5MyH68C03+oh6orhsFjtdvrxjsQRfYKHFPZK+C2f8qokNH5jx/oY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLmNAV9UVIWJOsUKxpqrYQjU5/MJMCaxXtLsBy32TVQ=;
 b=mCwcbwWobY5eQ0unFpI1Tl5krvrmfAK/yqT4RThoJiZLRIA+D5sNJxpAb8P5pQZGuce56lpUyh0a5jO6TnGNg+YbdFIP1c3BegSC1p+AM1uoqldKJKFZVlThugI83afnRmxAEBBBhhrW0AOu35HWQWBIN13hkBR4NHLyZTJZHy/lf9NBAOFresX7Dz9N6+r45qeXGLhyT2TIeE2oks0Oc83KVhNAIon6+sOHYnLbxCwBrPlW2alOWFwelTAESiQ68t/Lcd/q/YBqDTA7/bHw0k55Go2u57m+UmpdUHnqYxxu++Prr1Wv/bvMxd2jvNAyEZOPUGxs/ry0fHJmb2VkzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLmNAV9UVIWJOsUKxpqrYQjU5/MJMCaxXtLsBy32TVQ=;
 b=QPTdbE87XYNquL+MmeNjzn99kpST7Scco2BBHjaVgLtoTZrJeqbWMrR7uMBkjFRnlMdC8MQ3VRVOTKZpDlliy0wPZYFfG5iPTD9YAmluCw0JdlUE/xnqFJ9pfz9OEVz64cWv/Z7m2t4kr2rGC+2qma4gMLeex+jONHlMjYjRDE4=
Received: from AS2PR08MB8576.eurprd08.prod.outlook.com (2603:10a6:20b:55f::9)
 by DB8PR08MB5436.eurprd08.prod.outlook.com (2603:10a6:10:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Wed, 28 Sep
 2022 08:31:47 +0000
Received: from AS2PR08MB8576.eurprd08.prod.outlook.com
 ([fe80::2851:6fde:6262:5b76]) by AS2PR08MB8576.eurprd08.prod.outlook.com
 ([fe80::2851:6fde:6262:5b76%3]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 08:31:47 +0000
From:   "Michael Williams (ATG)" <Michael.Williams@arm.com>
To:     Will Deacon <will@kernel.org>,
        Besar Wicaksono <bwicaksono@nvidia.com>
CC:     Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "vsethi@nvidia.com" <vsethi@nvidia.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Subject: RE: [PATCH v4 1/2] perf: arm_cspmu: Add support for ARM CoreSight PMU
 driver
Thread-Topic: [PATCH v4 1/2] perf: arm_cspmu: Add support for ARM CoreSight
 PMU driver
Thread-Index: AQHYsAsiCzQrPgyEQ0K9q7o3XCKJDa3rtSeAgAkRkUA=
Date:   Wed, 28 Sep 2022 08:31:24 +0000
Deferred-Delivery: Wed, 28 Sep 2022 08:31:12 +0000
Message-ID: <AS2PR08MB8576965E67E5C4B31487011E8A549@AS2PR08MB8576.eurprd08.prod.outlook.com>
References: <20220814182351.8861-1-bwicaksono@nvidia.com>
 <20220814182351.8861-2-bwicaksono@nvidia.com>
 <20220922135257.GD12095@willie-the-truck>
In-Reply-To: <20220922135257.GD12095@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: C51E2B6074B41B46B1EB7454A261E962.0
x-checkrecipientchecked: true
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: AS2PR08MB8576:EE_|DB8PR08MB5436:EE_|AM7EUR03FT018:EE_|AS1PR08MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a767059-4e74-42bb-741a-08daa12bea5c
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: IFLjUgrPo0/qOhNxazxoy49RICbqvn2mrlrRwrxnFtBoTX5tq155S/shPNTInu366OzWNmoKClL4/cgTN0gMk+yn3yOb/dpf39VLsuZZmpM/mqUqG1XstDn3jNH87wu+g1/HGwdnUKq5xf1tRLfrn06pC23UucrKWuAbKGmFQdEPwZkcHVWxwE9XSne9kW59c6DZFSFN0n4Vo0zjou6+7mYKO8gkUOvIRZwxdi/f8kOKUgTkVSr8U7nI7Bs6SFnCLzYE1IEzEpUJE7PZoMVgZ3R/1tmQS02sP+nBn3iClZ0CdJQ6Thy0nLO4oyNp9IyUIA/0lxOVnkoQJoOguyGFYQe+u2bSy8hzPeGCTYunX02Bc/QwQ9mOpg8u+dIyCBHzspQlC0tpyrC3FHOadq8AuphIy2lVhKLGMvzlFsNiHDBALcKwtOk03H1y/N1JPoEgboZA26hLuSTfH7ccssBE04IezaUo8gNhhBUKHtn3BFL34z2jxY+qERaKgzXsfy9u++BLavF8aZTscgSxMaxjAt1DTf4G5UNl+hPX1xIhWSA7gD63CT+ubSW2NpWO3j6X58h3ADJ9hti59iQu+0D13nduigzFHSRPVXhqnN1uZb2xZzY6yVa1oCBQu8+ilMhN+eopleIjebADseJTiO9DVceaxsJjFRzryztY8rklmsU7OP9gvXRQkF6tny8EqmQRHf1UDB2e5I2l58IDfASqv9oDpZc1icGL3rGN4UXknkXvA5PyY+SGADVCUBt3s5rB8sLUJlOmZbIQdGjeMOv/bg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8576.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199015)(52536014)(86362001)(76116006)(4326008)(8936002)(33656002)(66556008)(7416002)(66946007)(8676002)(64756008)(66476007)(54906003)(38100700002)(316002)(5660300002)(38070700005)(110136005)(122000001)(53546011)(7696005)(6506007)(41300700001)(66446008)(83380400001)(71200400001)(2906002)(9686003)(55016003)(478600001)(6666004)(186003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5436
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c661b004-2d81-4089-2496-08daa12be1bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMsVTdhBKaQqj8qgD/AyU0Ya/JnRYsNfxo+7TN71cLx2BKM5s3yb0vHesq+zvfUPIbs2fRMGnO2FjH9lkjORsPG3Ghfiwv7xHHHFZ5+y2ARhByTqVemlPbJyszSaeArAjkiqMuElalOcYK94AnYvkMbqgMw2CUBaOFJZRrYBtT3AH5MIHt2kvUWnZ/jWgUdKeWVCMEJbKm+KhEjP2f+MJ9sTDS8qig0mR3SOEPCHG7tpJmniNdGUCPBQFbOuYskit4bJZYTOPBZg8XPM8UawsPJYMitj78HONab3lHjf1DObBENMQp/5zaHNLwOLCpxkhXrNbaUKWvxL9KA3gWzNDKK+BsnqX/Ii+z8Gb9HfUhxY37R3PqUYx6nByauPbBynx0+oyxpWSkPwoc4VTShXbxxQrc8kbu14pN9tfSMHWNaxCSCz80BU5dagkPGAFOS6GHrvvllATy+vQC1h3sYRlMj7XQ5MgLtJ8d7RE3B8SaXxTVSYv8yqmJFHdpbk7uEH1yWUPVmpL2WOK9ukBiwyz2tkWq5tpWg9baOzrfk/hliOCvkvrEGFsS3cepLntl6/84QSVaoPeJxmRPb3cc9oDOq707m72PEOCaCP4wWnEcufKqPQocVNjNF6uN01MEsm5mw1INlUMgCVxaB0WY7fOo75IkF79EOu2iqi6qPMXujGZnYWQ30DSxI4eDjO7hilUD6nlf7q7C8DOp3WeRclUs+pf4XHC7nb+R8q8kUDEbZQbFr+2949dShMWXbNR9TwbCj0PByE1Ro8Q3RvhLTvTA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(47076005)(336012)(26005)(9686003)(186003)(478600001)(6506007)(7696005)(82740400003)(316002)(2906002)(36860700001)(83380400001)(53546011)(33656002)(107886003)(6666004)(54906003)(110136005)(8936002)(52536014)(5660300002)(41300700001)(70586007)(356005)(40460700003)(81166007)(70206006)(4326008)(8676002)(450100002)(40480700001)(55016003)(86362001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 08:32:01.3158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a767059-4e74-42bb-741a-08daa12bea5c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7610
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: 22 September 2022 14:53
> To: Besar Wicaksono <bwicaksono@nvidia.com>
> Subject: Re: [PATCH v4 1/2] perf: arm_cspmu: Add support for ARM CoreSigh=
t
> PMU driver

[...]

> > +/* Check if PMU supports 64-bit single copy atomic. */ static inline
> > +bool supports_64bit_atomics(const struct arm_cspmu *cspmu) {
> > +	return CHECK_APMT_FLAG(cspmu->apmt_node->flags, ATOMIC, SUPP); }
>=20
> Is this just there because the architecture permits it, or are folks
> actually hanging these things off 32-bit MMIO buses on arm64 SoCs?

The CPU PMU is often exposed on the CoreSight APB bus (32-bit), and althoug=
h this driver wouldn't normally be used to access that PMU, I wouldn't rule=
 out similar legacy APB and AHB interfaces being used for other PMUs. A fur=
ther issue is that the CoreSight PMU model includes a number of 32-bit cont=
rol registers.

Since issue H.a there is an alternative 64-bit native PMU interface describ=
ed in the Arm ARM, which must support 64-bit atomic accesses. You might exp=
ect this to also appear in CoreSight PMU at some point soon. That would nee=
d some additional updates to this driver because all the registers are now =
64 bit, which changes some offsets.

Regards,
Mike.

