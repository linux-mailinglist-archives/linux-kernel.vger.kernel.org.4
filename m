Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2156C61E2E6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiKFPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiKFPQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:16:42 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77002BF5A;
        Sun,  6 Nov 2022 07:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYnEicsmSWcuQh58AKZTGvq+HAkLZOJ7PI2cBVo9CLbjocLXT6FwtzREF+4trT4Ms29FHNcjx4QHh+HUdXxXRXmqxVOyWepDC2zieKeAIlrdAiiaYPvl5A36iey/4ZfK/vwp3amEBzi6N7x4V6in/viEStK2qfhqG6ryrYmT4NoGFHFV3fQXXW9RDUS9sMN7e4wahk1sQIn1uy3CrD6fS60Q7BKNrpo+r3cqRKk2VE6x73QOOgRO2H+0OsdOIQw8tYl9YWumDM3CmyFzitSVbV9BceMQkQZ755xRXyUUeeJ44//xPgQql4HZnLDl68zcBZ/ipdAgll5Ex+1NGioAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlJ7icsU3OGTDZQ1HSQPld7xT6gLK9jSxIYEV3X7p7s=;
 b=FuZQdnmzvFjzmwWa17p4LFXrD1aO7YByS+0jFfYAnKurSGNTibnI+Gn1RHu8d5T1fedVsPPuRQC3KjVkLHy33fO/9vNR51SWjDoxN7qd9Ah3KBuXBuG+UAROaHV5578LzsnvEH/VfAmGgtMVROulsGYMqQYmCxZz/eGkd3T53mflhDKGAbT2Je8hozF0hwXdTwggmD0eEbmdpoIDZCwg8JIOE3a1njDlDWBkbxMO4eqNQkyoqJixm3+uLzIVuly2mbLx6U1wCe0NNuZ/OOFsGmoXijkMSAKibEzqEHXJc7Ti6pXlGgVBvnTWNA2GHDXEib6Nv954Md1kS1QxJDs8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlJ7icsU3OGTDZQ1HSQPld7xT6gLK9jSxIYEV3X7p7s=;
 b=nL5OIF0WSJO7P+YVzeo0P06bXwdahGeh3JrRx8zsFIbDNUHLMASA3f7tHCtjjrLvMxy6vzMlY3fRpoddm3byjcGYEfwqWoFTtqaoxPNIoAf+1d1yFTU26Em+Ni4GP8u9JN51xNfh9CbDOqWNuML1wrOqWgzaB/xecOLcC0o5wgQ=
Received: from DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Sun, 6 Nov
 2022 15:16:36 +0000
Received: from DM6PR12MB4044.namprd12.prod.outlook.com
 ([fe80::a844:2258:ee96:f671]) by DM6PR12MB4044.namprd12.prod.outlook.com
 ([fe80::a844:2258:ee96:f671%8]) with mapi id 15.20.5791.025; Sun, 6 Nov 2022
 15:16:34 +0000
From:   "Neeli, Srinivas" <srinivas.neeli@amd.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
Thread-Topic: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
Thread-Index: AQHY0mDPx4RdhC+WcUWOcyuX5wtnOK37UmgAgA18EuCAJNRsgIAACp4AgASSIxA=
Date:   Sun, 6 Nov 2022 15:16:34 +0000
Message-ID: <DM6PR12MB4044C5194CC4C70A36E2F4F9933D9@DM6PR12MB4044.namprd12.prod.outlook.com>
References: <20220927110257.41963-1-srinivas.neeli@amd.com>
 <20220927110257.41963-3-srinivas.neeli@amd.com>
 <20221002162528.GA2900147@roeck-us.net>
 <BY5PR12MB403335B81FB6DF09D65A08B593239@BY5PR12MB4033.namprd12.prod.outlook.com>
 <BY5PR12MB403330D43906BD6D617DB0DC93389@BY5PR12MB4033.namprd12.prod.outlook.com>
 <20221103172432.GB177861@roeck-us.net>
In-Reply-To: <20221103172432.GB177861@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4044:EE_|CY8PR12MB7634:EE_
x-ms-office365-filtering-correlation-id: 5e2fff2a-dd30-4237-957c-08dac009e46f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 602qE0GPfXKVDnsU/x+33YG57jzhUbOHGJOZQjlP1ufEGdvr38s0XAe5KU3Qmco44f8HJ2ba5K68tdQ/eqhMmtb+oHvokAjDvPBZZYcj8QAWrf3p+Ds2btZf29myCKMKzuNE7C/vJWhcSjiMtm9doXZg6nFgH74451NIJehhvA69HuV/IUG8gMpcaOa0tG0/WnfA9Z6R+O3s1ONgTThXnA+if18Nv1azyEWRYfiRb+DoRajEv1+lgcS+1eJdGGVd0OPp1aiA0mvKYsvYtjJ064l6v8ux81AVsuhK5rIXgpDY/9PNHYo2s7fniptGU0K/8fvD3khfcUY0znZKAH7a+9npPE5BXJ6jxuKMECtHUbqkstViCb/WdQPO/x0wX7G/DjlzZ70RZawTxXxeLI1ntd7v48rMFmJBwn9FuamHlxY8TNOpO9FGCHFv9bwnKTJ/fR1xo630XQq0owcbXHIZTALUeeuWne0Reaw88+5rxrWUwmcFOFpwr6BSBegHOhTJc3qDZQ+TdisU2+ZRaAKtrggVFLXnv+aFdx/pGl69jAt8NuPlXl/LQqediagPTmFt8eJjYdKgrtpvq//62pbClmQZlvGeqQS3+DH3XnVH6Jq4tQPMXVa2Z3bE48otuJhI/sEXIvmHVrRyk9QuQWVFR6RGK7Zqhw5yfdDTDJBJEdy9JkIkvZ2959M5mXGKTZV5G0ZBjdTVq1+fUS7Jk/igo+ySRw56kCcL+9O7u0LVywofzJHwyfU9I+id0AJaVR46841MTBXkXr5kl88nbFg4bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4044.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199015)(83380400001)(54906003)(6916009)(76116006)(4326008)(5660300002)(8676002)(33656002)(30864003)(66476007)(66556008)(186003)(64756008)(66946007)(66446008)(26005)(41300700001)(52536014)(8936002)(316002)(9686003)(6506007)(53546011)(38100700002)(7696005)(2906002)(55016003)(86362001)(38070700005)(478600001)(71200400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?45Agyd2ufSrF2xyuf/ayC51xkw/qLg0LwvVfQvFmAzmey9mVCM2fGfGn4HDJ?=
 =?us-ascii?Q?Z8Wtuxwm9EUA37jQhdQp3Pf4l5LTu1QZyKjw5eE0DzZ53QJtzIIM3lgcXHfx?=
 =?us-ascii?Q?TV0a6wDyhMWjCb2nuOXZjAFcVq1QusyiNrDoiIGEDg74yzRs4qz6itv0EBRK?=
 =?us-ascii?Q?DhGSSB2cGq2vDXojqeOdDkcrv87gDo0Oa4MXY6VnKYF7C/MR6ehaCPo24omY?=
 =?us-ascii?Q?gGVhss/DPe4MgHTt8xL3ALJ8Eqjj7jCjNgKCV4xbPv8ZjuSy/a6rruKqHDR8?=
 =?us-ascii?Q?jV361/zPIaYKz4rIjuPeQkhyFSb+sY3MDXu/KfjCoPZXo1A7bPt/BsNvOZ02?=
 =?us-ascii?Q?Tm1qMSB99XqXRgilQHDNAQr41o9rcYTS7HkzZ9nzXVtvOAnADPNtOLPwc971?=
 =?us-ascii?Q?uTdnnEl4R/S0JElqU3kirdjQLDQHcEbHCWErd3l6ny5wB+Nfk37eQJ6xAXMS?=
 =?us-ascii?Q?kh4mXacCpS9Wbu9I0BWVA5Gn2rvqlWZfqMYW7HrAsCDRTVURY7zKL/brCHRB?=
 =?us-ascii?Q?oqxICmPOnBES1GH51UE1Aet8z01CIocL3Nfy4sHc5L5gvL/tFVjqnJY9EO4w?=
 =?us-ascii?Q?E+PxoHYtWekNT9l3UZOx/caYlepM2ZFGTdLyYjs3wcDjFlRVLvKUNS02/oNh?=
 =?us-ascii?Q?4ngzd50vZ8Ai8pTdd0nSwp60UQKy5r5kfEUC7RNaanrWbKqeTG2cP6g7WS14?=
 =?us-ascii?Q?R4D6JZrF5ifTpCHf7Vlo7XuApIKtFXf7IYlDSPIQWk6rXfYAgK6TbrMDDLLo?=
 =?us-ascii?Q?3aaPIBXU2/+pWx279j6LK8YXc58qLHE1hfTp577QtKy1z5hhujYsDwT+FOdA?=
 =?us-ascii?Q?Cee9zBMlhC75oPQr1DoB2M5WTZbz2f6TFJ+49nqOzxme26UZ2Oq4/+jdHu0s?=
 =?us-ascii?Q?lT/1MQ5WKkzOaRAQIUbq5yEvznEK0Q6LRNCnCHjxewEZxGSmqqxroh4r+mwz?=
 =?us-ascii?Q?RqWxQZYFA9l0t/NU0J3amygrQ/up0s/b+W5HoOXgevlMxQSkFuojPzHFKztq?=
 =?us-ascii?Q?cLBZVQE09+HbzqiLVaXAvuwrDKUBQkkPZ3/jmQe39DnXZC1Gyay9BETKnEpk?=
 =?us-ascii?Q?qLHwYTf51/cyyoGJ/RSGiAs15Az1jl0rwATpaa7hy5AInDlgRZ2pxAv3TkZb?=
 =?us-ascii?Q?UV10zbuLDf9pNVynKb6cxSau1xvmEaVPWV/x0YEQj2RomqR3r8al67wBCfsh?=
 =?us-ascii?Q?fzMDu+qyfdcx9B+6PJj31s+SPjx2uf9Q8P+nEX3VVYgusMz+1qf2Ohoo3bM9?=
 =?us-ascii?Q?3lCLkP2Tx8bz37q+wahSw7kkvAhJ/qKyEay7iCPGsXV5A5vWa1fpvvdswaQe?=
 =?us-ascii?Q?ukr+uVVV+hr+1z2SlHCTuj0qEXWSuCEJM+CzAc5yumGzOE9iyCYIW95u6RRn?=
 =?us-ascii?Q?EJXz2biU2NXewXjCvrHhEBtn/j42vmgiI7R/MIpfyYNSm4sqFHxZ+0K8aRoj?=
 =?us-ascii?Q?gDhauFjAHt6a9Bb80WaH/31M/EpuLGhUPNa1Lcf7tzpmE3/bmji64iAmw1AK?=
 =?us-ascii?Q?bUC1JHrc0s8XBMxvr9XNluSfi51HMgBt05YUH3T3Rcd/K04Ph6YxMzSlv7CD?=
 =?us-ascii?Q?eDlVIVncuFH8Ek8peSo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4044.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2fff2a-dd30-4237-957c-08dac009e46f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2022 15:16:34.5634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdAXX+0Q9L+LY0T9071Y6FOHE3XHlp2WqCUHWP9nCr2fIIGSENkTGS6PIBTs7cC+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Thursday, November 3, 2022 10:55 PM
> To: Neeli, Srinivas <srinivas.neeli@amd.com>
> Cc: wim@linux-watchdog.org; Datta, Shubhrajyoti
> <shubhrajyoti.datta@amd.com>; Simek, Michal <michal.simek@amd.com>;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; git (AMD-Xilinx)
> <git@amd.com>
> Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window
> watchdog support
>=20
> On Thu, Nov 03, 2022 at 04:51:14PM +0000, Neeli, Srinivas wrote:
> > HI Guenter,
> >
> > > -----Original Message-----
> > > From: Neeli, Srinivas <srinivas.neeli@amd.com>
> > > Sent: Tuesday, October 11, 2022 11:57 AM
> > > To: Guenter Roeck <linux@roeck-us.net>
> > > Cc: wim@linux-watchdog.org; Datta, Shubhrajyoti
> > > <shubhrajyoti.datta@amd.com>; Simek, Michal
> <michal.simek@amd.com>;
> > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> > > kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
> > > kernel@lists.infradead.org; devicetree@vger.kernel.org; git
> > > (AMD-Xilinx) <git@amd.com>
> > > Subject: RE: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window
> > > watchdog support
> > >
> > > Hi,
> > >
> > > > -----Original Message-----
> > > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter
> Roeck
> > > > Sent: Sunday, October 2, 2022 9:55 PM
> > > > To: Neeli, Srinivas <srinivas.neeli@amd.com>
> > > > Cc: wim@linux-watchdog.org; Datta, Shubhrajyoti
> > > > <shubhrajyoti.datta@amd.com>; Simek, Michal
> > > <michal.simek@amd.com>;
> > > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> > > > kernel@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-arm-
> > > > kernel@lists.infradead.org; devicetree@vger.kernel.org; git
> > > > (AMD-Xilinx) <git@amd.com>
> > > > Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window
> > > > watchdog support
> > > >
> > > > On Tue, Sep 27, 2022 at 04:32:56PM +0530, Srinivas Neeli wrote:
> > > > > Versal watchdog driver uses window watchdog mode. Window
> > > > > watchdog
> > > > > timer(WWDT) contains closed(first) and open(second) window with
> > > > > 32 bit width. Write to the watchdog timer within predefined
> > > > > window periods of time. This means a period that is not too soon
> > > > > and a period that is not too late. The WWDT has to be restarted
> > > > > within the open window time. If software tries to restart WWDT
> > > > > outside of the open window time period, it generates a reset.
> > > > >
> > > > > Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> > > > > ---
> > > > >  drivers/watchdog/Kconfig       |  17 ++
> > > > >  drivers/watchdog/Makefile      |   1 +
> > > > >  drivers/watchdog/xilinx_wwdt.c | 286
> > > > > +++++++++++++++++++++++++++++++++
> > > > >  3 files changed, 304 insertions(+)  create mode 100644
> > > > > drivers/watchdog/xilinx_wwdt.c
> > > > >
> > > > > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > > > > index
> > > > > 688922fc4edb..9822e471b9f0 100644
> > > > > --- a/drivers/watchdog/Kconfig
> > > > > +++ b/drivers/watchdog/Kconfig
> > > > > @@ -304,6 +304,23 @@ config XILINX_WATCHDOG
> > > > >  	  To compile this driver as a module, choose M here: the
> > > > >  	  module will be called of_xilinx_wdt.
> > > > >
> > > > > +config XILINX_WINDOW_WATCHDOG
> > > > > +	tristate "Xilinx window watchdog timer"
> > > > > +	depends on HAS_IOMEM
> > > > > +	select WATCHDOG_CORE
> > > > > +	help
> > > > > +	  Window watchdog driver for the versal_wwdt ip core.
> > > > > +	  Window watchdog timer(WWDT) contains closed(first) and
> > > > > +	  open(second) window with 32 bit width. Write to the
> watchdog
> > > > > +	  timer within predefined window periods of time. This
> means
> > > > > +	  a period that is not too soon and a period that is not too
> > > > > +	  late. The WWDT has to be restarted within the open
> window time.
> > > > > +	  If software tries to restart WWDT outside of the open
> window
> > > > > +	  time period, it generates a reset.
> > > > > +
> > > > > +	  To compile this driver as a module, choose M here: the
> > > > > +	  module will be called xilinx_wwdt.
> > > > > +
> > > > >  config ZIIRAVE_WATCHDOG
> > > > >  	tristate "Zodiac RAVE Watchdog Timer"
> > > > >  	depends on I2C
> > > > > diff --git a/drivers/watchdog/Makefile
> > > > > b/drivers/watchdog/Makefile index cdeb119e6e61..4ff96c517407
> > > > > 100644
> > > > > --- a/drivers/watchdog/Makefile
> > > > > +++ b/drivers/watchdog/Makefile
> > > > > @@ -155,6 +155,7 @@ obj-$(CONFIG_M54xx_WATCHDOG) +=3D
> > > > m54xx_wdt.o
> > > > >
> > > > >  # MicroBlaze Architecture
> > > > >  obj-$(CONFIG_XILINX_WATCHDOG) +=3D of_xilinx_wdt.o
> > > > > +obj-$(CONFIG_XILINX_WINDOW_WATCHDOG) +=3D xilinx_wwdt.o
> > > > >
> > > > >  # MIPS Architecture
> > > > >  obj-$(CONFIG_ATH79_WDT) +=3D ath79_wdt.o diff --git
> > > > > a/drivers/watchdog/xilinx_wwdt.c
> > > > > b/drivers/watchdog/xilinx_wwdt.c new file mode 100644 index
> > > > > 000000000000..2594a01c2764
> > > > > --- /dev/null
> > > > > +++ b/drivers/watchdog/xilinx_wwdt.c
> > > > > @@ -0,0 +1,286 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Window watchdog device driver for Xilinx Versal WWDT
> > > > > + *
> > > > > + * Copyright (C) 2022, Advanced Micro Devices, Inc.
> > > > > + */
> > > > > +
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/ioport.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of_device.h>
> > > > > +#include <linux/of_address.h>
> > > > > +#include <linux/watchdog.h>
> > > > > +
> > > > > +#define XWWDT_DEFAULT_TIMEOUT	40
> > > > > +#define XWWDT_MIN_TIMEOUT	1
> > > > > +#define XWWDT_MAX_TIMEOUT	42
> > > > > +
> > > > > +/* Register offsets for the WWDT device */
> > > > > +#define XWWDT_MWR_OFFSET	0x00
> > > > > +#define XWWDT_ESR_OFFSET	0x04
> > > > > +#define XWWDT_FCR_OFFSET	0x08
> > > > > +#define XWWDT_FWR_OFFSET	0x0c
> > > > > +#define XWWDT_SWR_OFFSET	0x10
> > > > > +
> > > > > +/* Master Write Control Register Masks */
> > > > > +#define XWWDT_MWR_MASK		BIT(0)
> > > > > +
> > > > > +/* Enable and Status Register Masks */
> > > > > +#define XWWDT_ESR_WINT_MASK	BIT(16)
> > > > > +#define XWWDT_ESR_WSW_MASK	BIT(8)
> > > > > +#define XWWDT_ESR_WEN_MASK	BIT(0)
> > > > > +
> > > > > +#define XWWDT_PERCENT		50
> > > > > +
> > > > > +static int xwwdt_timeout;
> > > > > +static int xclosed_window_percent;
> > > > > +
> > > > > +module_param(xwwdt_timeout, int, 0644);
> > > > > +MODULE_PARM_DESC(xwwdt_timeout,
> > > > > +		 "Watchdog time in seconds. (default=3D"
> > > > > +		 __MODULE_STRING(XWWDT_DEFAULT_TIMEOUT)
> ")");
> > > >
> > > > There is no reason to make this writeable. There are means to set
> > > > the timeout in runtime. Those should be used.
> > >
> > > Accepted and will update in V2.
> > > >
> > > > > +module_param(xclosed_window_percent, int, 0644);
> > > > > +MODULE_PARM_DESC(xclosed_window_percent,
> > > > > +		 "Watchdog closed window percentage. (default=3D"
> > > > > +		 __MODULE_STRING(XWWDT_PERCENT) ")");
> > > >
> > > > The above is problematic. This should really not be set during
> > > > runtime, and the behavior is pretty much undefined if it is
> > > > changed while the watchdog is running. It should really be set
> > > > using devicetree and not be changed in the running system.
> > >
> > > Accepted and will update in V2.
> > > >
> > > > > +
> > > > > +/**
> > > > > + * struct xwwdt_device - Watchdog device structure
> > > > > + * @base: base io address of WDT device
> > > > > + * @spinlock: spinlock for IO register access
> > > > > + * @xilinx_wwdt_wdd: watchdog device structure
> > > > > + * @clk: struct clk * of a clock source
> > > > > + * @freq: source clock frequency of WWDT  */ struct xwwdt_device=
 {
> > > > > +	void __iomem *base;
> > > > > +	spinlock_t spinlock; /* spinlock for register handling */
> > > > > +	struct watchdog_device xilinx_wwdt_wdd;
> > > > > +	struct clk *clk;
> > > > > +	unsigned long	freq;
> > > > > +};
> > > > > +
> > > > > +static bool is_wwdt_in_closed_window(struct watchdog_device
> *wdd) {
> > > > > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > > > > +	u32 csr, ret;
> > > > > +
> > > > > +	csr =3D ioread32(xdev->base + XWWDT_ESR_OFFSET);
> > > > > +
> > > > > +	ret =3D (csr & XWWDT_ESR_WEN_MASK) ? !(csr &
> > > > XWWDT_ESR_WSW_MASK) ? 0 :
> > > > > +1 : 1;
> > > >
> > > > This is confusing.
> > > >
> > > > 	return !(csr & XWWDT_ESR_WEN_MASK) || ((csr &
> > > XWWDT_ESR_WSW_MASK);
> > > >
> > > > should do the same and would be easier to understand, though I am
> > > > not sure if it is correct (making the point that the expression is
> confusing).
> > > >
> > > Accepted and will update in V2.
> > >
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static int xilinx_wwdt_start(struct watchdog_device *wdd) {
> > > > > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > > > > +	struct watchdog_device *xilinx_wwdt_wdd =3D &xdev-
> > > > >xilinx_wwdt_wdd;
> > > > > +	u64 time_out, closed_timeout, open_timeout;
> > > > > +	u32 control_status_reg;
> > > > > +
> > > > > +	/* Calculate timeout count */
> > > > > +	time_out =3D xdev->freq * wdd->timeout;
> > > > > +
> > > > > +	if (xclosed_window_percent) {
> > > > > +		closed_timeout =3D (time_out *
> xclosed_window_percent) /
> > > > 100;
> > > > > +		open_timeout =3D time_out - closed_timeout;
> > > > > +		wdd->min_hw_heartbeat_ms =3D
> xclosed_window_percent *
> > > > 10 * wdd->timeout;
> > > > > +	} else {
> > > > > +		/* Calculate 50% of timeout */
> > > >
> > > > Isn't that a bit random ?
> > >
> > > Versal Window watchdog IP supports below features.
> > >  1)Start
> > >  2)Stop
> > >  3)Configure Timeout
> > >  4)Refresh
> > >
> > > Planning to take closed window percentage from device tree parameter.
> > > If the user hasn't passed the closed window percentage from the
> > > device tree, by default, taking XWWDT_PERCENT value which is 50.
> > >

Does above explanation looks fine to you ?

> > > >
> > > > > +		time_out *=3D XWWDT_PERCENT;
> > > > > +		time_out /=3D 100;
> > > > > +		wdd->min_hw_heartbeat_ms =3D XWWDT_PERCENT *
> 10 *
> > > > wdd->timeout;
> > > >
> > > > min_hw_heartbeat_ms is supposed to be fixed after probe. Behavior
> > > > of changing it when starting the watchdog is undefined. This will
> > > > likely fail under some conditions.
> > >
> > > As I said in above comments versal watchdog IP supports
> > > reconfiguration of timeout, so every restart we are updating
> > > min_hw_heartbeat_ms based on timeout.
> > >

After stop we are reconfiguring the min_hw_heartbeat_ms, do you think still=
 it will fail ?.

> > > >
> > > > > +	}
> > > > > +
> > > > > +	spin_lock(&xdev->spinlock);
> > > > > +
> > > > > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> > > > XWWDT_MWR_OFFSET);
> > > > > +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base +
> > > > XWWDT_ESR_OFFSET);
> > > > > +
> > > > > +	if (xclosed_window_percent) {
> > > > > +		iowrite32((u32)closed_timeout, xdev->base +
> > > > XWWDT_FWR_OFFSET);
> > > > > +		iowrite32((u32)open_timeout, xdev->base +
> > > > XWWDT_SWR_OFFSET);
> > > > > +	} else {
> > > > > +		/* Configure closed and open windows with 50% of
> timeout
> > > > */
> > > > > +		iowrite32((u32)time_out, xdev->base +
> > > > XWWDT_FWR_OFFSET);
> > > > > +		iowrite32((u32)time_out, xdev->base +
> > > > XWWDT_SWR_OFFSET);
> > > > > +	}
> > > >
> > > > This if/else should not be necessary by using appropriate
> > > > calculations
> > > above.
> > > > Anyway, this is moot - as said above, changing min_hw_heartbeat_ms
> > > > after probe is unexpected, and the code will have to be changed to
> > > > use a fixed value for the window size. With that, all calculations
> > > > can and should be done in the probe function.
> > > >
> > > > > +
> > > > > +	/* Enable the window watchdog timer */
> > > > > +	control_status_reg =3D ioread32(xdev->base +
> XWWDT_ESR_OFFSET);
> > > > > +	control_status_reg |=3D XWWDT_ESR_WEN_MASK;
> > > > > +	iowrite32(control_status_reg, xdev->base +
> XWWDT_ESR_OFFSET);
> > > >
> > > > Why is this enabled unconditionally ? I would assume that a user
> > > > specifying a 0-percentage window size doesn't want it enabled.
> > >
> > > Plan to add a check for closed window percentage. If user tries to
> > > configure 100% of closed window, driver configures XWWDT_PERCENT
> value.
> > > Configuring 100% of closed window not suggestible.
> > >

Do you have any feedback on above explanation ?.

> > > >
> > > > > +
> > > > > +	spin_unlock(&xdev->spinlock);
> > > > > +
> > > > > +	dev_dbg(xilinx_wwdt_wdd->parent, "Watchdog Started!\n");
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int xilinx_wwdt_keepalive(struct watchdog_device *wdd) {
> > > > > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > > > > +	u32 control_status_reg;
> > > > > +
> > > > > +	spin_lock(&xdev->spinlock);
> > > > > +
> > > > > +	/* Enable write access control bit for the window watchdog
> */
> > > > > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> > > > XWWDT_MWR_OFFSET);
> > > > > +
> > > > > +	/* Trigger restart kick to watchdog */
> > > > > +	control_status_reg =3D ioread32(xdev->base +
> XWWDT_ESR_OFFSET);
> > > > > +	control_status_reg |=3D XWWDT_ESR_WSW_MASK;
> > > > > +	iowrite32(control_status_reg, xdev->base +
> XWWDT_ESR_OFFSET);
> > > > > +
> > > > > +	spin_unlock(&xdev->spinlock);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int xilinx_wwdt_set_timeout(struct watchdog_device *wdd,
> > > > > +				   unsigned int new_time)
> > > > > +{
> > > > > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > > > > +	struct watchdog_device *xilinx_wwdt_wdd =3D &xdev-
> > > > >xilinx_wwdt_wdd;
> > > > > +
> > > > > +	if (watchdog_active(xilinx_wwdt_wdd))
> > > > > +		return -EPERM;
> > > >
> > > > Why ? This will be the most common case and means to change the
> > > timeout.
> > >
> > > Versal Watchdog supports reconfiguration of timeout. If we try to
> > > reconfigure timeout without stopping the watchdog, driver returns
> > > error immediately. Reconfiguration of timeout, Stop and Refresh not
> > > allowed in closed window.
> > > User can trigger set timeout any point of time, So avoiding
> > > reconfiguring the timeout feature using driver API if the watchdog is
> active.
> > >

Please share your comments on this.

> > > >
> > > > > +
> > > > > +	wdd->timeout =3D new_time;
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int xilinx_wwdt_stop(struct watchdog_device *wdd) {
> > > > > +	struct xwwdt_device *xdev =3D watchdog_get_drvdata(wdd);
> > > > > +	struct watchdog_device *xilinx_wwdt_wdd =3D &xdev-
> > > > >xilinx_wwdt_wdd;
> > > > > +
> > > > > +	if (watchdog_active(xilinx_wwdt_wdd)) {
> > > > > +		if (!is_wwdt_in_closed_window(wdd)) {
> > > > > +			dev_warn(xilinx_wwdt_wdd->parent, "timer
> in
> > > > closed window");
> > > > > +			return -EPERM;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	spin_lock(&xdev->spinlock);
> > > > > +
> > > > > +	iowrite32(XWWDT_MWR_MASK, xdev->base +
> > > > XWWDT_MWR_OFFSET);
> > > > > +
> > > > > +	/* Disable the Window watchdog timer */
> > > > > +	iowrite32(~(u32)XWWDT_ESR_WEN_MASK, xdev->base +
> > > > XWWDT_ESR_OFFSET);
> > > > > +
> > > > > +	spin_unlock(&xdev->spinlock);
> > > > > +
> > > > > +	clk_disable(xdev->clk);
> > > >
> > > > This doesn't work. The start function doesn't enable the clock; it
> > > > is enabled in the probe function. If you want to enable the clock
> > > > dynamically, you'll have to enable it in the start function and
> > > > make sure that it is stopped when unloading the driver (you can't
> > > > use the devm function in this case). You'll also need to make sure
> > > > that the unprepare function is called when unloading the driver.
> > > >
> > >
> > > Accepted and will update in V2.
> > >
> > > Thanks
> > > Neeli Srinivas
> >
> > Could you please let me know your thoughts on "one line comment
> summary".
> >
>=20
> Sorry, I have no idea what you refer to. Searching for any of the words i=
n
> "one line comment summary" in this patch doesn't give me a hint either.
>=20
> Guenter
Sorry, it was mistake from my side. Please ignore it.
I responded to all open questions, please suggest your comments.

Thanks
Neeli Srinivas

