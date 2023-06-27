Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AEF73F894
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjF0JUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjF0JTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:19:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27199106;
        Tue, 27 Jun 2023 02:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNiG31g1gxD7rlA6iEtIDONuu6Q0Dayph0wajbwCLbR8ySgwhCxypV0gFcCLjOPzFNyB1dmugHSoF0ayRd/ItCsIKw7cp7X41FkqMAUbcix5qcocv6pD13oqezBtkpN6WV8pVgBi2CNyQb9a+v7VV3QWi5mLs8ja8t3WqxF4ERa80eykkDKvAcLySeqXGiaZwbNau+wsVKFAa/AzxI+LOWPXGjjgNyFHbeMSfaWPrxm4j+UOkn3yYqAd2cqKQ91PD8goorYp25jzEpS4G/oMx06WHiKEu7vltUQu1QM+XPr2/15HIr56bxCdH7VCjCiiRznM1QpAv/0mImzGOgZF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7heYl/XOUrCV6rppMlz4MHksi6bF0TIBx48rlDObYY=;
 b=Nbsc4WJ1rKYImKzo5XM8UHlwvAS7UNaouIDVCuXFeUPRpZvdKVG9JkPnVZfVPvea8NLW5tCa5hMZeAxaHwFmdSfFlWofHhWxqXFXp8FJxAQZis7K6K1aJRby/cgCMVQW5Ny946bFM4gX/egL99gueaZU3fcKo7xuTqnxAHvnXEYpFDSueIfrYP8LZsGT+saI0I+UNxR4N4mCEdalKJ4mEq8ZvKNVDh1WeDD0rp9HnUQBt+O9PWW+q4SOmPrqjkw8DIN/FOS1VJRlw9YKRFm8MP13X5TgUpNJBw8K0SRF1mL2fqOFeGr82i76x3fJMdXhI/3fvN8cIeNLe2dlo6YGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7heYl/XOUrCV6rppMlz4MHksi6bF0TIBx48rlDObYY=;
 b=ITPF2qM9A0yMpFJjsz3CV3C7dqf/KzNjw/V6ZE6Qwj7TWc57G4OYl0zX+ybqU5oc+G/PFEUsKj3yekkn0jwLf2gi2RGStLlDl6htzTxqcqmYhCzyZXVvXgHRTVlr2PCCr5sSUhcNqu9IWJ9ghxjsb74uXfdJfDecO6b7hXSrhIg=
Received: from BYAPR12MB4773.namprd12.prod.outlook.com (2603:10b6:a03:109::17)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 09:19:52 +0000
Received: from BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::dd8c:65dc:5934:7ecc]) by BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::dd8c:65dc:5934:7ecc%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 09:19:51 +0000
From:   "Katakam, Harini" <harini.katakam@amd.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     Jose Abreu <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: phy: mscc: fix packet loss due to RGMII delays
Thread-Topic: [PATCH net] net: phy: mscc: fix packet loss due to RGMII delays
Thread-Index: AQHZqNda5+DRbHxbQUikxPH5Tvdjz6+eXxZA
Date:   Tue, 27 Jun 2023 09:19:51 +0000
Message-ID: <BYAPR12MB477315C261B843487E2F21949E27A@BYAPR12MB4773.namprd12.prod.outlook.com>
References: <20230627091109.3374701-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230627091109.3374701-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4773:EE_|LV3PR12MB9233:EE_
x-ms-office365-filtering-correlation-id: becf4601-1fb1-4b68-cb12-08db76efa97e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bfatvjbjzWYXPEHksmfGhwTDBQhW9MJMpB1YaDx4dmK6M1gWSR9P8jY6Pgj1fCaVV8afzeyOl21tyAkA5n4ZY7Y/YCTACesnAugbdLMJiWcyBLLfe0V65QNfKoG4tbTT/1MZyTlphMkVaQSrWIjLpEwRtnnKSeZiAhqrRkjHZnWtSmWSBjilNWoyosVvb8LO3z6ZsuUp6RDCMYhPFGCo2kPIpV5yiSrsnfH/WCCedRwMCow4lRhaB5eq6Mac1qTVV6swTGkerg6habDnxPNNTQdJFkYhcdWBhRxRa3I/Pvmf0w8xe65eJC5o7Pbnn3KUiMBCoUXW8aRFRU6xPxwxKUQza+aHbeA61seFRw6XGBQaG683I4oVGSjXUjiIfZ7GjxjHAEbwhBHdZuefrQY5n/MEBZd8+kWWBPpsKo/g1l5r+wH26zmooOmXH35dbETIySZ2jjs+tRogPiGRjtPRD070wzEzyjvGQD0vPHDFb7P1C2dYMKU7p+tyYwd4c2wQewqUiUUBTRA07OhqWKbOAxkmSmqr27nzFIiVD8kK6Se6aMjT8f5a9qcxo1PqA0mifvnfbq3HR5sCgIhnFCRavdMJhYscys50XtU07m3qbce/cdHGnRsnfH+KPWGtoaDE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(2906002)(38070700005)(186003)(7696005)(71200400001)(122000001)(38100700002)(83380400001)(6506007)(53546011)(9686003)(4744005)(26005)(55016003)(110136005)(41300700001)(54906003)(86362001)(316002)(478600001)(66556008)(66446008)(4326008)(66946007)(66476007)(64756008)(33656002)(76116006)(7416002)(5660300002)(52536014)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2F2MjSNiuEE0KvqWTIr3U+MDp2D7m+kA6JaUV7+gufKecxUaWy4vzLpfmJpK?=
 =?us-ascii?Q?S5YEM63M9VdeJbhuRGXN7lNNIaw/nLJ3UktUxinQcoJyG5hISVC9EgnG5c93?=
 =?us-ascii?Q?EZYAefdM0+4aXC0jyPs4Outhf6an/DykoRQ/GflCDYYBI7EvPp2a0wd/K70K?=
 =?us-ascii?Q?3Zi2GEXSPsa0NnpSi8Qg+HRGWwb5qQxweDK5DAidlkjorQkmZyR4etuPvKiU?=
 =?us-ascii?Q?hEowEY9c1DA/QqeGHOUCPxijn17SgHq+8n415w65hpqhfcCM0MezRTG6wCmm?=
 =?us-ascii?Q?OcYBB973FOY2ag5J/XSag2PprKc8L5/N345zk3qhjM1bXfYzGtvc5PLF3iKT?=
 =?us-ascii?Q?hdQaXqxjF4fsTrDYpFeiON2R/Vna7ndlysoHgFK6u+ejn46rooVfFtbhBhqa?=
 =?us-ascii?Q?5jCyDYVMx1YjZ2Hc0P3nPZPGsM4F7Kq3LxWCwlaG4u/YAW7G5Y3xPjXXMfHf?=
 =?us-ascii?Q?+rFk89Rs2Rsh+nwQaQu/NdCkvSdYoe1FfhLcaOz6XEv7A2M6Itr+jAzyCJQQ?=
 =?us-ascii?Q?GdOloJ4QYArpIJOO8rXFKl2YkUOCCZBUrhUIj4JGimVmVP4l+dFeRPUZka7i?=
 =?us-ascii?Q?NsGX9MtdfPhhW8OWAlQ0hcULv3H4DnxKBjR635VM0HAivCUCeA/VyEu6sNon?=
 =?us-ascii?Q?X4S+OQPxHp1JdwbN/Qkj6UPKPfSkATwAdXn9R4/RquWYbCopQQ8weIpA4KMz?=
 =?us-ascii?Q?D1zrLn4nHfD92R7sBDSMRmh64HYfw7+XxVaRdcd1ueW9aS8lj6u2SYpoBDhP?=
 =?us-ascii?Q?M5xYUz/FkfUxdyJ28oJaq3F5T8I6RX3apYWT9hTJ3YIdGUDijyHeN2PsqSZF?=
 =?us-ascii?Q?gP2m4WgrtdgeqxhJQqU0Uq0ZZ6BNWObSUOHuKCDhkw/elBbUyLxMbw4kXqsX?=
 =?us-ascii?Q?g6N8nyeq/Q6eBAQc13TSKuSJeJ9Nx7iuTn/CbO0g/JqBU9JcuZGzX42BDOMN?=
 =?us-ascii?Q?FXnqtqC7wcX7a8ylkBmJrYnTrvFNKBQMszLh3EyNVt7NoDa1/xxxfzcAkcSh?=
 =?us-ascii?Q?L9jhZ6orpuZQUR9Ye/VBeZaqKJaLyttnqJWxOff1DpoFM8mCeX7pntiULXsY?=
 =?us-ascii?Q?9YsrHASPKqKjLbpuaZN02+fYrLTl4TFabVf5qivW8HzssHIMAIf2+xytxprb?=
 =?us-ascii?Q?yzcw87CZ9fj5LU2vHckpYaU17N6TA1sowMk8nkccckvkg7oCXXnBla/Go6Ky?=
 =?us-ascii?Q?wx3kuulkwsBjx0QIdJtr4yiHjOaO5eFTf4qOjKNTVUzUeCR5c7dyCEYjirak?=
 =?us-ascii?Q?F4PhZ9KNspmtn8VkOEa09EnT5Bv7yFfeTObE9s568rHVkfD4wAcnJebIbWba?=
 =?us-ascii?Q?rxB/plCbuWpFcrAyCH1/F7CAOK2t77H2/piNO7wzInNuDykd5FBuAj1+1SNK?=
 =?us-ascii?Q?9uis+q9fTThCTAgQLXHZYAUmI9CVBlxQzKWhwIw0oYIrKMkAkrxGZKLGM2YV?=
 =?us-ascii?Q?XpDWDCvCFVqbc4jNbQg5JjBCuhCaI3Q6AqnuugpWWDMay4nxiS0rsY0isQOr?=
 =?us-ascii?Q?cMmkleg60iLmmp+M3hLxesFLFNczesPRJbDU7pDVI+4vWD+7XnURY+T34J2x?=
 =?us-ascii?Q?GoKl5AIPmWLES6zPRKI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becf4601-1fb1-4b68-cb12-08db76efa97e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:19:51.5461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyAB9ggtpW2xon32TsKLQbh6dRzmJ6tlGKE9BsbW3smSBOdhtuZ2gbjC0RRBoQ2R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Tuesday, June 27, 2023 2:41 PM
> To: netdev@vger.kernel.org
> Cc: Jose Abreu <Jose.Abreu@synopsys.com>; Andrew Lunn
> <andrew@lunn.ch>; Heiner Kallweit <hkallweit1@gmail.com>; Russell King
> <linux@armlinux.org.uk>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; linux-kernel@vger.kernel.org; Katakam, Harini
> <harini.katakam@amd.com>
> Subject: [PATCH net] net: phy: mscc: fix packet loss due to RGMII delays
>=20
> Two deadly typos break RX and TX traffic on the VSC8502 PHY using RGMII
> if phy-mode =3D "rgmii-id" or "rgmii-txid", and no "tx-internal-delay-ps"
> override exists. The negative error code from phy_get_internal_delay()
> does not get overridden with the delay deduced from the phy-mode, and
> later gets committed to hardware. Also, the rx_delay gets overridden by
> what should have been the tx_delay.
>=20
> Fixes: dbb050d2bfc8 ("phy: mscc: Add support for RGMII delay
> configuration")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Thanks
Reviewed-by: Harini Katakam <harini.katakam@amd.com>

Regards,
Harini
