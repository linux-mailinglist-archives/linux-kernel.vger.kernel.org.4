Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D132737529
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjFTTgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjFTTf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:35:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C0DE58;
        Tue, 20 Jun 2023 12:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj/ARfgXqHnOoog901fNHp+59OlNUB16o6f4j+KZWVJfUE9gtzaQ1B8IkoUrVw7Nv7dlhC2GWF3+WmHlid5LHeshO09tb01xxED3QAnOJ4EQWVxYm0PyvSL2H47u6komni/kI/yobuaME8TebtQgjqXQYNdmztJZYhCVXjFGcby4E2AUzy1rgix+Wdm9BHjQP4KnEkWj8h9Oi2I5Cs4ns+reGJhtGL1BsujDuTBvbWAWrWu7orF2pFVr4768JOzbmItsSAMs5Cr6dMvXZ+iGGyFfJFKZRx45zb0v2xD9vY7EpngTarcCwDAyLq5YSXOGsuyE3GcC2q+SclR9FZxgaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2C/xiWvbyJUCUowY6eJwd1U1/qgcepfIdLTM9OHUdbw=;
 b=QtlaXHxiKwcq8JmFMU3frjoT4ULNtcZhhzmZqQ4GEGm71+AhELbInvwJE6vD0fvdwVFSguZaZXcMVAsb32Uj2sIp/I++SLpo0xqYvLzAmxtkwlJQ3iHwCsVBFBxt8fbSBlxj8UrbMK6ylU3AyMcO559Tf+TCdXcVzdZzBL2ApjRNGZLjLrznKgTtqNin1lHYZ6omRwaoTepH0ydwAl8HfcNJY5hjXn4YTEv/WMQ7Qc/BG74/u8a2yveSHnWWKuxr57LNKzC35sOeY/68QFCFBTEJnYwoFeKifrkHpmZ7Jk34cZspU4sge/K/L2bN0PlW/L2YYX2LdPvrN/HNDMq0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C/xiWvbyJUCUowY6eJwd1U1/qgcepfIdLTM9OHUdbw=;
 b=I+2cobgJghPo9cFKJUEeEB8cjMm+auT+T/WcVsnZlzYMuh+rB8vmDVz26RI2WxeqwxJLC/zRf2nsLKGGqWmkxziIzuse5E7YmL3iBu0xfyuCC94vXVUZOSOuIgqYkQei8e5xdInyfOrXYgOHEzBFEZDEEViI6UDhNgOvEq8f0go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA1PR08MB7165.namprd08.prod.outlook.com
 (2603:10b6:806:184::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 19:35:55 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 19:35:54 +0000
Date:   Tue, 20 Jun 2023 14:35:49 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] input: touchscreen: add core support for Goodix
 Berlin Touchscreen IC
Message-ID: <ZJH/lTA0TWmdEfJN@nixie71>
References: <20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v2-2-26bc8fe1e90e@linaro.org>
 <ZIvTfE5O31NKnywd@nixie71>
 <a4f36bef-7c2c-08f4-bf93-fe1f0f1d315e@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4f36bef-7c2c-08f4-bf93-fe1f0f1d315e@linaro.org>
X-ClientProxiedBy: SA9PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:806:28::34) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA1PR08MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 371c3e5f-8c36-47d9-1acd-08db71c5905a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAGMLPmhtCPur0Dn8EML0CusWRDmKiszAYOqlzYyrR29ulwzAgkmA5YUy7ozupUZ+Jlj7tSyBFnUHikN0kNNxJlXQA4He3ODse9opJvM0M7YbqG5iL+9CFN4TqMFjTivbtvJjSUlnvy7GMeZt119h8lR8/dW+oJI9yqg8om2e7QsZlcoWgBx2OIVi3VqbTOCoXfIVt4OTrHWph6+DiBZFPpuvN+FegSsKnWmIaHY+NeUvLKgQcj3y8kTlF0FL29aLKHJn/LOa7sogWSGf1usum9+RfpYPqDCQR5qRQOW+D6BUyEZk6T970mu5gIsjJJCzYcl0UNhl5Rz2fbgL0k5A6uNt7he3XnaAY+zEGVZ560BePI9dmMJWs1ranPGnIhmF2wjtCjKAGPiKsjwjxOUGlrVwVEIEkknD6unCXJvGyyJdTWgkeUOASexPYilNI7HlqvQj+l/A3t/awzjEJLL7whMK9f6TNwca+5TA12kczvo5sSXAsqlOUmv7//veAuaJKMwJ9h+g385fjHSmCtkl/PWPh/d1nURJbPa3ToWWvx+nB3AI/N7/sTjGXCMP6D+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(396003)(376002)(39830400003)(346002)(451199021)(7416002)(33716001)(86362001)(83380400001)(38100700002)(41300700001)(8936002)(8676002)(66946007)(5660300002)(6916009)(66556008)(66476007)(316002)(26005)(6506007)(6512007)(9686003)(6666004)(186003)(6486002)(478600001)(54906003)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b9aSmzld9UHsNN5wjdMR4Ug8bXDPDK0QNpeKZh98hktJhtxK3BUBXdDoQd6/?=
 =?us-ascii?Q?plN8jLM1TQL912Kkb/zF088Sq9SCW49qtXEUy04b9/61fP/Co6qdqdQbFYb/?=
 =?us-ascii?Q?cli24GDc67ML6RQD9grl3WSDqhRsN9HkxqVq6NwBvKMG3wB2s15jcj7rYRyf?=
 =?us-ascii?Q?maTgrsWMP7li7hv0xtCt6PvHXMU2XuInp1dPXnNG0MHWH005saH88qnLSryQ?=
 =?us-ascii?Q?r51k3gkeB1BoOhXeQpMD0rrd/0LVWupN6Xx9pLrearglnwx8PVS1rFeQWGOj?=
 =?us-ascii?Q?GpHTBZ1DLSEPEzitflvJoGWhAYZl2SsKWo5Va+SBOwjR3sojmPHZyExzO4/r?=
 =?us-ascii?Q?wf9I7h/8pxkMUuV7GmkfUpZM+5KzrfijqwYLxEJMnSVLEF8iRRAAwpiS5r2P?=
 =?us-ascii?Q?StuduK6RYUgE1XfmxQx+zEQ8WFH7PhcuWDTUbMkYG0ArUC7CgGoIW9IF7c8i?=
 =?us-ascii?Q?3bgTKvkUODu3TgAJSQ4vDEimjWT1MGb0ExT2vxg5yPOwW4zSiOK3L3Khrete?=
 =?us-ascii?Q?d0XXf6vTsqCsCALY9x5gWiS5ZUo+xNwt6UPPYEPLiWPZAC3gh5KtHV5IPbT6?=
 =?us-ascii?Q?qodo/6/TcYq2DWnE3Z+bniVP/D8pPJkbOTjcdghOYESI8lmB6CrykUnThsHM?=
 =?us-ascii?Q?wb6erD7LihiAGTF7cQBBzDaEjcEk7CKdwwiAWNSTa3z2E1c8lc1DssE9DLOZ?=
 =?us-ascii?Q?axxYAupYslfN+eEm4fSafF9PKkwszrNx/y5E11w52nrogKM7sNhgwHPm4TZV?=
 =?us-ascii?Q?V3iQtyypvQ1AIn4H69DO1hbRO/2VjZQn0SHwpLs7qA9f7hui8XO9gGXEennm?=
 =?us-ascii?Q?1HXOV7hMM2W6K9zQtEIDLvOIoUefV3GK1sYU+j2NXprchFLhLjRl8mhX3zFE?=
 =?us-ascii?Q?xJtd7Yd0hJsIcmEdHAHXNlAsXDrKNLulY58By1YxLaCnH+2gDr4s2IAuRODY?=
 =?us-ascii?Q?546+QPwAYnWexiImY8KuYT8Eg7akt/e2DuVEz1JmAC/m35ABcTAicA2Fsx6V?=
 =?us-ascii?Q?GKrKjDhF1qLzRHtyPpnqlGo5RP2ItlkGuNdt7AhUUXkpXZ1QfaGndMzvXxiI?=
 =?us-ascii?Q?/IXkK/d7sFDc0lcsovC48F39+HeUyhMykjKiwYWsx3DirBZUFK7ZvKtTeCXM?=
 =?us-ascii?Q?ZnpDr9K30BP2E7by6tFCSFK36N3P78wfSybu9h3MKHUAlvlapJoa8TdGyoB/?=
 =?us-ascii?Q?pcp7KeyJAsCYu2GG5UFs5PbFsq4Yq0ZY1+FfocfDSMHO7eKM9yzdNiF4RzlR?=
 =?us-ascii?Q?EoA7Py3O2hwG9MOlH6b/AFGqECJPy1BwRbH6z7eNVTH+O2+v7VVjpakXItjj?=
 =?us-ascii?Q?DUqoVYIWa57kP9P2W1xtuX72bvB0d9eZ5IC2MjXDqdZXiP6RlPQ9AR2Kwl+x?=
 =?us-ascii?Q?GrOn+y03rcuhoIg5Cx+w8JnerdwSdUS5bQ8GeH0iwxrjSSyx7+jpxIXDMKZL?=
 =?us-ascii?Q?MLM+toESI7xtKax63UNXEVBhsroVhn1345PoORH1tz50ZfxEM+gJcrJBUz1h?=
 =?us-ascii?Q?Gph/+T9N9pZcPOaovC7OiGNH9G4omV/8c2pGRm1xVC7200DlOMQFqTYpm28/?=
 =?us-ascii?Q?XMqZOMsT7Ry7wprNeE+mXp/u4r5ecikML+VpTm9i?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371c3e5f-8c36-47d9-1acd-08db71c5905a
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 19:35:54.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: addZM3+N6KehIuBPSgBLBg1P2eEYo4aWg4i5uk2S5aK3hgFleGVwIravsRYWiDEICm+orSkLIrTjduIDlEZohQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7165
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Jun 20, 2023 at 08:38:20PM +0200, Neil Armstrong wrote:

[...]

> > > +static int goodix_berlin_power_on(struct goodix_berlin_core *cd, bool on)
> > > +{
> > > +	int error = 0;
> > 
> > No need to initialize 'error' here.
> 
> Th refactor I did needs it to be initialized at 0 because the if() always calls return,
> but yeah it's kind of ugly.

Ah, you're correct; I see now.

> 
> > 
> > > +
> > > +	if (on) {
> > > +		error = regulator_enable(cd->iovdd);
> > > +		if (error < 0) {
> > > +			dev_err(cd->dev, "Failed to enable iovdd: %d\n", error);
> > > +			return error;
> > > +		}
> > > +
> > > +		/* Vendor waits 3ms for IOVDD to settle */
> > > +		usleep_range(3000, 3100);
> > > +
> > > +		error = regulator_enable(cd->avdd);
> > > +		if (error < 0) {
> > > +			dev_err(cd->dev, "Failed to enable avdd: %d\n", error);
> > > +			goto power_off_iovdd;
> > > +		}
> > > +
> > > +		/* Vendor waits 15ms for IOVDD to settle */
> > > +		usleep_range(15000, 15100);
> > > +
> > > +		gpiod_set_value(cd->reset_gpio, 0);
> > > +
> > > +		/* Vendor waits 4ms for Firmware to initialize */
> > > +		usleep_range(4000, 4100);
> > > +
> > > +		error = goodix_berlin_dev_confirm(cd);
> > > +		if (error < 0)
> > > +			goto power_off_gpio;
> > 
> > All of this cleaned up nicely. The following comment is idiomatic, but I feel
> > the goto can be easily eliminated as follows:
> > 
> > 		error = goodix_berlin_dev_confirm(cd);
> > 		if (error)
> > 			break;
> 
> Break ? in an if ?

Ignore my comment; I lost my place and thought we were inside a loop :)

Kind regards,
Jeff LaBundy
