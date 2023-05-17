Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A410A705F35
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 07:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjEQFYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 01:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjEQFYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 01:24:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBE140C0;
        Tue, 16 May 2023 22:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2QixDTuxCtNTDqePIHMC/sk0RaCapjmF9JY8CpDDCPVR8JR3oksfCZpcqi7fKdPjm/JNYy4iSLCD8eORQWLIhsIHcutEEKC9NhKUisWrOiyF6LbQoATpd+WapMKNxCpM/KN9tJSz+E5E1H1SiAOvT34Kwecxh+REkBUnWKiVk/Tmr6jq76j6+ZPcK+DJ3L7E/zJp48hy+MlRTHXOVOB03qPS937MDWbGBHgabL+rtJtm0bS208YO4xByS5W9E14WQdQ1zfjIdWjios/vainiutjTWeoOkPSAvCJWzZbqfgqy0zWYxBXZG10+qYZ4aMzvyzs6E95D07zLPAkzJiR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJhPpy7vamQoF6pU/tkzjFEFt3wlQIGt622jKY+FB1k=;
 b=oXG7Y6VbODzf8xLmeZSE2HZm2QK/Bs+GnhQR+ZqU60XCVGHNoVwz4CKobENjSrTSkLixVtesNoW83EPZ94mHNWcId8dOa91OgLEZ9R7tyRGd+2ZNqM/GEIbYZJxyErN+Rt+Lm7CVaqPPmfMXX84W103TL5baAJIdDJko3dS4BOeLAPfwh6cSK1Vb6W2/tWmANE+6DpIWFb7+8ZWCYY255yoHsOMAi5+I8iN5f4+8ZdFkVm24TXFJt55UDdMMhzZPeTkruw9n/pkdwCtDm8ZZzt1mgnfhApvaW4O7pK9PWEb6Ur4MRw1s+1XPNtDQOSq30JL2C2QbHOssFfK/0xsr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJhPpy7vamQoF6pU/tkzjFEFt3wlQIGt622jKY+FB1k=;
 b=mMkMuHui+nenb0xgAbs0baZFG9VCbRVk4o6alDKBCg0xIfEZlY8f+r8Yo6ekZuGdUlYYJFJxMQctW6p0QAMkAnYEVshGHLcqRLlBwtgxQuAW8htIK3tkzCigmVQ8d5o1GJ3Zrwdp5IBHQZsbupsnz9Wl8lK1rSHsHK1ZxNL+MxM=
Received: from PH8PR12MB6675.namprd12.prod.outlook.com (2603:10b6:510:1c2::15)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 05:24:10 +0000
Received: from PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::a9cc:895f:cc74:30b7]) by PH8PR12MB6675.namprd12.prod.outlook.com
 ([fe80::a9cc:895f:cc74:30b7%4]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 05:24:10 +0000
From:   "Goud, Srinivas" <srinivas.goud@amd.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: RE: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before its
 ready
Thread-Topic: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before its
 ready
Thread-Index: AQHZgpUsoHY1RY/m3UymshDymAXTqq9bRGXAgAAPWACAAQ67wA==
Date:   Wed, 17 May 2023 05:24:10 +0000
Message-ID: <PH8PR12MB6675A433C8B129AA96B5C853E17E9@PH8PR12MB6675.namprd12.prod.outlook.com>
References: <20230509164153.3907694-1-ckeepax@opensource.cirrus.com>
 <PH8PR12MB6675F6CC30254C5EED898FD5E1789@PH8PR12MB6675.namprd12.prod.outlook.com>
 <20230515125458.GT68926@ediswmail.ad.cirrus.com>
In-Reply-To: <20230515125458.GT68926@ediswmail.ad.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6675:EE_|DS0PR12MB9040:EE_
x-ms-office365-filtering-correlation-id: 309d51fa-bda4-4739-ffc4-08db5696f1cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YobA5d/tXKLFc9Dlx3hFsWOi5kA+Kga9mHQGlMLRNzVZlQk9Z8Ap3Ux3ANyMDF3ZDiAz/qExiO8O5hYGQwSekcUKdELCtQlfwp/6e9xthHRmlK+7zRNSa+NYfsV//qdOxHUM9blwimSouV1oNU98aXgkCGAqCUl97LMe9MCOpwU5i03az8GdX4MtIHOnjecZSMbQCd8RH64sltaacrRA+uS8YKvkN+A/dV6uL7x9il/So3SkOiu+ddFM+pMigP3JNIhwXmJXHGNC4lJURi1IraxW9uijL2mFlTwXQx2hxL1rlufF9mS9+Nf588a0tY6q4nLCVFGJqCvute17Ks1BursdSaSFvn32b2jzTqhiEDmskD1w5OR/z9j6yYrxZHZUz9kNRKYgk0izRZAJ5fK/YxgOIwXzvvey6RX3bg135yiLu6uhGhBcw/uOncwzdLRMAJfc8zHVQs34RoMTJAwu2tzt+TTXnIoKUiOYWAy2uf3AEV7X8hHNHo0YvtK36k/u61U9PARqdD3uZCaGN7jLspcGSIdolwKCORxckBEZLJnUEmC6xZ+R435w4ohiJvqC78ZI2JAJe/B8xzCfWseP9/80FnBim0JQFyqStRVUIk9R7G34DxtPoTa6PzdmvvoT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6675.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(5660300002)(8676002)(52536014)(8936002)(54906003)(83380400001)(9686003)(6506007)(26005)(122000001)(38100700002)(38070700005)(186003)(41300700001)(478600001)(7696005)(71200400001)(55016003)(33656002)(66476007)(86362001)(66556008)(66946007)(66446008)(64756008)(76116006)(6916009)(4326008)(316002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SYKpaaWNWJ7WWoCmd+mSs3FjHrsgzxui+lTKztySZe0oAPZ/hzv0WFsMu0Jk?=
 =?us-ascii?Q?Vorak1c5yuNEAsar1S74Vyb2QI1YRGzitwT1RHGRjMDPPeKbV2waPWwbiLCX?=
 =?us-ascii?Q?c9FQ+6ck0zAaUZVbd+RYeS0JVpzhnPYV+qsd1HeUInPYLSX0dF4xWgyfRZ2N?=
 =?us-ascii?Q?qOBoUtelis3lDEdn80PgqHcWE20BR2LFXdrNabBqFQw7spn1I7NVByiTFNUW?=
 =?us-ascii?Q?2zo6gu1WMx3LqLmhYOWoeE+j7nkkRt3D8SydSFSPyVL1WSqS2yhjFMzz2RgO?=
 =?us-ascii?Q?EcnekWiOGikmUCwgiWZe1izT5dbyejRrLeuXjli6X/UH7U41dNNJqDgw5wT1?=
 =?us-ascii?Q?sPKfLgSD6P57aKeTji55s8v0ff4Ju/9goeCvxXJD8yrYsil+OFFwcqPjysxj?=
 =?us-ascii?Q?e39y7Afxfeux3m2aZSQXlhpaMj0CFXZ1ieaPWMOGHc74316qzOVLA61jEC0x?=
 =?us-ascii?Q?YOzFZG59nsxiguq/ckXINrRNmIl4AbzIyggjS1Am1rbfsrWAwJjGdInvNbCF?=
 =?us-ascii?Q?XuSSO4eNU5WIJ10UC8YV6pgoXd5f+8WlKpfbUVNRDuIAJmUC0wbWA1N+1sY1?=
 =?us-ascii?Q?TKKky3LAopTMU8F6DK9OeG79/kf5t4wO/r+38GQyYhWXHlo1AWAgoASks6ZY?=
 =?us-ascii?Q?qodkc5TuVkjno30RClxZ8gYcaG4xE6EzTett5DC1A1MxfQP5w/bI13fwfe75?=
 =?us-ascii?Q?SYiU6X3VGR9p99NlreXY6hXyycNqKBQpnHNLUOok1DQUNtnnKpmJnewYktFz?=
 =?us-ascii?Q?mITzih88CjheI77bllrLTK0EmKGwNiOLfCY8zxwvvc4tyDw8UHdbliSVfhHq?=
 =?us-ascii?Q?qilMd9y2VVIIEC+Yh5bPTak9ANRqLOY6uZrvVlMELGybNEvEyEhIOt0CObd0?=
 =?us-ascii?Q?dvDlQvddSj8ySaZ+fdHKn00B84k3FfX3Jly9Q1ZOFTrmeBx+fpJ6mZSrR6ri?=
 =?us-ascii?Q?spRB1x+0yH+PCyUU/kwS+NvkHs42FSR/7zbFPir/p5tgpSnyqvN8/SVLQJwT?=
 =?us-ascii?Q?GE1HIRg3iwa5fGzJXSVLBBWqFR50KoTH4tkJCh7EgJopyHazVm0qcpRDZjP4?=
 =?us-ascii?Q?KIvxpC30PPQSIrn0Zxw2Sywpekh/SjhMM8TuMUcK5cQl6sURLqJTN7ejxJjJ?=
 =?us-ascii?Q?gp5jhHLj+UGwH4IR3FSGU7UCWWLhHi7rqxeBJaVROAoAfWYTLm44NZRZCUC8?=
 =?us-ascii?Q?vyR+YQfg2OYzGRpIvtM9UR3VejLHN5w86J7qmtPJdZv+uy3xY1I6FyTtoOWQ?=
 =?us-ascii?Q?O0iQ2vGb/eQ/ApBjQA/CSsv4MbZf7s1VgswX1/SzPUsTEFL82WtUUJ+ik9Kq?=
 =?us-ascii?Q?WU8IOZNXIu0FHrLd8p6+mWop4+16QzAeriM3hRRBEA7U9qpjepGJyvcuEDVO?=
 =?us-ascii?Q?z9WRkAxkBCLHjfuc3MN4PLOkQkHd/vnxsPld1lTgq93rBVBLOCbJ92Ui4v9P?=
 =?us-ascii?Q?K1a/bu1E6usQqXaKeXtVStU9F7tabc5mf0rv4rKN1DMSzMmJ05jBk2V1L7oa?=
 =?us-ascii?Q?tV7XqiY4vs/n8seoINptZ1lqxseG/qGicl7CtgD+kpGJEyWG98jSAsg7Ox06?=
 =?us-ascii?Q?O2DpMa0aitz2CiAnmtM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309d51fa-bda4-4739-ffc4-08db5696f1cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 05:24:10.4624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xawu5MRr4emxFOofk+U/DfR1QJMLDOeFvq3VeZf1HPa8YTRNoFR1TokfTqz9fP4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040
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

Hi,

>-----Original Message-----
>From: Charles Keepax <ckeepax@opensource.cirrus.com>
>Sent: Monday, May 15, 2023 6:25 PM
>To: Goud, Srinivas <srinivas.goud@amd.com>
>Cc: broonie@kernel.org; linux-spi@vger.kernel.org; linux-
>kernel@vger.kernel.org; patches@opensource.cirrus.com
>Subject: Re: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before it=
s
>ready
>
>On Mon, May 15, 2023 at 12:04:38PM +0000, Goud, Srinivas wrote:
>> >-----Original Message-----
>> >From: Charles Keepax <ckeepax@opensource.cirrus.com>
>> >Sent: Tuesday, May 9, 2023 10:12 PM
>> >To: broonie@kernel.org
>> >Cc: Goud, Srinivas <srinivas.goud@amd.com>;
>> >linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> >patches@opensource.cirrus.com
>> >Subject: [PATCH 1/2] spi: spi-cadence: Avoid read of RX FIFO before its=
 ready
>> >-		while (trans_cnt) {
>> >-			cdns_spi_read_rx_fifo(xspi, 1);
>> >-
>> >-			if (xspi->tx_bytes) {
>> >-				if (xspi->txbuf)
>> >-					cdns_spi_write(xspi, CDNS_SPI_TXD,
>> >-						       *xspi->txbuf++);
>> >-				else
>> >-					cdns_spi_write(xspi, CDNS_SPI_TXD,
>> >0);
>> >-				xspi->tx_bytes--;
>> >-			}
>> >-			trans_cnt--;
>> >-		}
>> >-		if (!xspi->tx_bytes) {
>> >-			/* Fixed delay due to controller limitation with
>> >-			 * RX_NEMPTY incorrect status
>> >-			 * Xilinx AR:65885 contains more details
>> >-			 */
>> >-			udelay(10);
>> >-			cdns_spi_read_rx_fifo(xspi, xspi->rx_bytes);
>> >+		cdns_spi_read_rx_fifo(xspi, trans_cnt);
>> Cadence SPI configured in Slave mode,  when threshold is half of FIFO
>> depth cdns_spi_read_rx_fifo() function continuously in read mode, due to
>this we see incorrect data received on the Master side as Slave is failed =
to
>update the TX FIFO on time.
>
>Apologies I am having a little trouble following this are you saying this =
part of
>the patch cases issues for you running in slave mode?
Yes, we see issue with this patch when we run in Slave mode.

When any master is in continuous read mode (anything > FIFO depth),=20
with updated logic cdns_spi_read_rx_fifo() function in cdns_spi_irq
continuously in read loop to read complete half FIFO data.
due to this Slave failed to write the TX FIFO on time and result in
incorrect data in Master receive.=20
Whereas in my previous patch, data read and write happening byte wise,
by which we are making sure data availability in TXFIFO on time.
>
>Thanks,
>Charles

Thanks,
Srinivas
