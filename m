Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1452B7467C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 05:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGDDBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 23:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGDDBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 23:01:46 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2982712E;
        Mon,  3 Jul 2023 20:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FB6yOrXxxwHpxDGEmulZTbQKnb3DYQ7hqMtcQ3B3GwS4Vv8uKm3dRvpXtLPFWw+sAOxMtBkXrx1I7deVEewu1ovLvZoezrLxyPeR+Je1b0mK9Oxs1MtoHKcFZSn/akjj5u3SEPeridur6M+3CLr2PsFpCrqLsSqXUufMBYoNeKHTXD0YebyYczOURVRc3KwiXS6CKkdsqPkYpSxllaZd1h5HqJXFqHZkT1o/LZbHwWOkyBsTCFH/3tAEDkEiWNL7hdwSbVb/6lWgosT3HiuiG6WqLy4QAjciPxYfB9b9K3fN34h9Rctfzn6jnvS56DfAhNcI4HfWf9j2eROrO1kwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDP8ogh8HMGwKSP9LowX6t4AUK+OD+djsvPOXV4zmkA=;
 b=F95lBUP6yJ0lCFLess1gBi/73ggZbDK/MnldT/eGX7QFk0o2PEMlw4pPr67JrMcrmRJFa8Z5YIfCMc0f4z6/ZKObGVuN+c4a1onj+zdzNOlYM9DMmvBKQ9mq0ugARp1x0Ug9w+91XExZfpodsXWwvrC863sG8sRu164pEwgA4g2bLj4/BU+d3sfJ22o+vkAUtgDroJUbeLymmmpQCNWrdhbYO4cCcTCwyLNxsyN+NN6gX9UAMffr7U75k8CmErKirJQcSZLuooVxvIuJpQrBGoz9T991BHd3LpQ4nB5hIf4kc6bORmq6KOl0IQb+6x49VRCkwAKzKxdhzo9R/r4gPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDP8ogh8HMGwKSP9LowX6t4AUK+OD+djsvPOXV4zmkA=;
 b=BGQ+VYKrLk7F4XIH0agu9OSWZbW+aTOFNBdJa0T1Qr+PKp/2eZDe/5nru775cu0v7uhqrkxAj6PxtLb4vFIeQIWrToWTgf4xGlUG8W8Q89n4QSdKraUy2+8VywG0WTOy6M9/P1jzwva85sGV3x5wRS9d09sbIoshbLcsc6Txv0DGdaCXxgsaX7MposB2zVj5c46sZ6eeftw3KVP7XmhT2kaebm3dCxqa5CFWDjQ4lZO+/7B4S1mzkmFwtO6AJty34xyNoGXOZEFkGHOQxXmMQkmGuIL/bYF4CIa67zFI33UdPDIqSSQw7t0UTRd+oataFF0pwLMWDDFHLP9RZ9kzAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by AS8PR04MB8498.eurprd04.prod.outlook.com (2603:10a6:20b:341::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 03:01:41 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::637f:a940:d807:34c2]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::637f:a940:d807:34c2%2]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 03:01:41 +0000
Date:   Tue, 4 Jul 2023 11:01:31 +0800
From:   joeyli <jlee@suse.com>
To:     Yu Hao <yhao016@ucr.edu>
Cc:     Weiteng Chen <wchen130@ucr.edu>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: How to reproduce the BUG general protection fault in
 hci_uart_tty_ioctl?
Message-ID: <20230704030131.GY5866@linux-l9pv.suse>
References: <20230628150140.GU21539@linux-l9pv.suse>
 <CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TY2PR0101CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::24) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|AS8PR04MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ff61de-de22-4eee-8c4f-08db7c3afdf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BsqjuWvTSbVHmXDYZhNcn6FLlFPByyTtGMrZ83gBMxY9IxFZNODFSY5/pOhJAnF9HfCkkW6fITDNRaZavck6oPb2FdDPyTxIfyI6gR0rSLQBmStseonGKNXlZewPIrhLeh/7+m5d4XVQuqPSm7tVjpzVy/7/juaStt+6euzeGe1ydRcCujy6OWkMVRZcdeNDbHQngA6ziaE8lFhR/e+oFT48Z/Kan8QdDoFti8dKoPowDerPMABywFvC43AkFd0KwF3Yc4r31+uXcUbGrXgglXiTvhMIhU/NypmxNpbBA715sPB7g8Isj5eYohCxkQCTI6fliCezfeKE4Q9iVyFskeAHJN9gJQdLZLShB1RBDEahc/bfJ/WoBuhBTElG32jPtzwRfF8HS//aLMZmPN32VUvW/2rBM0/FgoqeAM9sfd1v1DxhJ2T8vi15woqFu5ZZU0QEB7UXLSfUjMysVeQmRG9cKrR7qBA6wuSbbDAwbeWBfqcFttOqK0QsSOdSx+G6A/fqxwYTOyORGTwJ9CeRJUyQCl8wfM/fHf16E127oDi3yNPICOljz2CxP1y5YNweNlEky2OhEgFs1aOAGkize2CBTGIFWpsu43H0FdqRbgnXwWHeDroQsKUkJuOyL/qhimEv/lbs4dgBI3k87Sdi4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(2906002)(41300700001)(8936002)(8676002)(33656002)(36756003)(5660300002)(86362001)(186003)(26005)(478600001)(966005)(6506007)(6512007)(9686003)(1076003)(6666004)(53546011)(6486002)(316002)(6916009)(4326008)(66556008)(66476007)(66946007)(38100700002)(83380400001)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTJzbXc0MUEvSkJvdkMwMkhIRmlCM20rRW14aFR6T0dvcmU5NWI5VFNZKzVY?=
 =?utf-8?B?eEhYaXMwc0FZaXlyTmpYWHZuUGhlb1BONHNTRVdLbXpLK2VUZ0x0RWIxTUVy?=
 =?utf-8?B?b2tBZ0tXK01jbEhFYVlidkVJTjBLOW9GczdnaHBTVGVFVFlzTXlua2E4amJl?=
 =?utf-8?B?Ny9wWGJIN0h4cE0wMDRRM3p4ZUNpeW5oNU5RcFFLMlpadzhQV3RxZm4waDNN?=
 =?utf-8?B?Sk1BaW5DNTVZaU8xYllaVjRNaitIMWR2bnA0VUhISkFrVUtPQXNSaHc0RUt3?=
 =?utf-8?B?VEJjVjhZbytlOXk3ZHl4cWFuVVFNQ1owTjNWcy8yL0VhMzBobDV2V2tDNGxz?=
 =?utf-8?B?WHJUaFhNQjVPQkhmRjJQdDUyZE5ubHl4YTU4WFNJMFdXckNYMDZPZE9TYzBm?=
 =?utf-8?B?QWVVL1V1Zyt6djg3SW45akxpTEdXUzNvWEhFUEVrSGppR0NhSlg1ZXVZc25R?=
 =?utf-8?B?Q0xlMXc0ZVJQRUJaQzh2REhRKy9qaFJvQnFGSVNVeTdxOHJ0ZVZPZ09pTVFj?=
 =?utf-8?B?QVVJNTh2N3RRdlhRaGJCa0lXYzh6MitsZ0FiM2RKMm5CeDQ4UVlRRDZkK05X?=
 =?utf-8?B?b1luZWVtNzdrTVBzb0JtS01ub25oc0poWS9UbXFFYnJiWXVUeHUrU0dmS3M4?=
 =?utf-8?B?WFRIMlJtU01icERBVFg5MmlJeXRqc1U1VXRhOVhpSVBCVTdjek5jWXRsM2FJ?=
 =?utf-8?B?SmlLeDluenVoZ1ZGMFFyZjkxTDlNUjlFMHJSOFN3Z25DQWMvU21DblBkM3Zi?=
 =?utf-8?B?OWh3TTVuU2d4UW9KQjRUUE9nbWNMa0MrQ2k2c1lBRFFwYmZiTVQ5QzU5WWNJ?=
 =?utf-8?B?M1l5aE43STZLblhlTDlxVGdHdVhzbXVPdmpNb2Z5L1hPQU1WNWVZU3VabitY?=
 =?utf-8?B?QnhYRzhxQ2dwa0lNNTJOWnRscDVTbllRZzlrS3RaN2k1aklTc25KbkI2MXFI?=
 =?utf-8?B?bmZFSFhXTjVmOVJROVZaQm1XbktzRGp0YzZnUktTV1UzcDBqVG9uWEFZa2I0?=
 =?utf-8?B?MXQ0WWJ3bytBR3I5dnRxWnFHeE1vNzNMVnRiWFNGckRSWHMzSkwya25COVlq?=
 =?utf-8?B?djNjQXdVNXRyeW14WG5PYnNTNm9iNm5DWkNyay9CdXBZYVRzUjlNaEd5NUpK?=
 =?utf-8?B?eGllTk1VVWRVd1RrblZpQkNDM1N2eHhDL2RpbkdCODU1OGNNK01uUXdBYzZS?=
 =?utf-8?B?SUFWTnIwMERMQWFaRDRpN2c3ZnNLTWU3bjFORENlOUtnYVlaNnZacHo3d0d4?=
 =?utf-8?B?djJ2UElyL3l1by8xZURzQWk4Ni9lYnlXS05CbkNoK2FkK3dzenJrb1hPRGpz?=
 =?utf-8?B?ZVJ6ajhaeCtocFNFcGdLNWowVmtuejZ6Z1ZqYU5TWjR1c1g0WFAvVjJwUFJO?=
 =?utf-8?B?S3N2d0xXMHVuMTdyNEpqdHN6aVNRUGxsMmdPRCtCbHBQVHloNlI4OTZubjdB?=
 =?utf-8?B?MjZ4QW03WHFWZ3I2STByMUY5ZTNDbWhKa0VaL1J0WlQ4YmNKYURWUGQvcWt3?=
 =?utf-8?B?cG1GZHp1Y0Ruc1Z5VUczNndYL1ZiRGs1a1RPamZpQWxzcUYrcWF4Wm96ak9r?=
 =?utf-8?B?V2J5cExLR2tadG1YeUZ1UU5uWFMveXRqdVpxRUJKWFgzdG5LbkNTMzF2dWpj?=
 =?utf-8?B?TnMxMHhRWFQ5bVpESG1WUGZZbVd6cjM2MGoyZ21ReGthMUI0QUVnTUhiL2V1?=
 =?utf-8?B?THYrb3haTThEaXlHSkF6YkFTL0pTNlc4ZzgrRXR1cmJ2NkhzY3JkRDFLWmxz?=
 =?utf-8?B?Wjlia3FxZG9VZ2h3NGJhNWlodGFnNVRjMHQxUXVURy9ZeGNLNk1YVkxSM0hX?=
 =?utf-8?B?eVBxTjRIWjFtZDZ4d25yQ1owNElUaXNwN2lyQldSVXBaUklGOC8zU3ZzOGFy?=
 =?utf-8?B?ZDRMV2lTUUtOK0xIL3V1ZzJ1Lzg2azE0blp4dDhJcnZoc2ZJMEJIdXcyVExh?=
 =?utf-8?B?c0lieStsYlhvaTQ2RkdSQXlxK0tHVkhBSUNvZzVkQ2ZDSUVLaUxkUlg0YVIw?=
 =?utf-8?B?SjIwOVlXbDVQY3gweVdtRHFUbHJQOEh3MDdmQVp6dlNsUmNGRjBvTlJ1UUJv?=
 =?utf-8?B?WHFBbnVpa3d5SW5iQklSanpBMVlvUTllajVJWVdtUXVkT3ZSVG01ZWFkdTIx?=
 =?utf-8?Q?tKaE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ff61de-de22-4eee-8c4f-08db7c3afdf5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 03:01:41.5941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyrTZDVtqSS349HNHUHIlnurWite8sG+HJdz1W3GoL4eSMEYNXI7axQEe0XTf97Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8498
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 28, 2023 at 06:57:47PM -0700, Yu Hao wrote:
> Hi Weiteng,
> 
> Could you give more info about the bug, e.g., kernel configuration,
> qemu arguments.
> 

Base on kernel code, looks that the HCIUARTSETPROTO and HCIUARTGETPROTO
blocks in hci_uart_tty_ioctl() should use hci_uart->proto_lock. 

I have run the C reproducer a couple of days in qemu, but it did not
reproduce issue until now.

Does anyone know how to reproduce this issue easily?

Thanks
Joey Lee
> 
> On Wed, Jun 28, 2023 at 8:02 AM joeyli <jlee@suse.com> wrote:
> >
> > Hi Yu Hao,
> >
> > I am looking at your "BUG: general protection fault in hci_uart_tty_ioctl":
> >
> > https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/
> >
> > I am trying the C reproducer in your URL, but it is not success yet:
> > https://gist.github.com/ZHYfeng/a3e3ff2bdfea5ed5de5475f0b54d55cb
> >
> > I am using v6.2 mainline kernel to run the C reproducer.
> >
> > Could you please provide suggestions for how to reproduce this issue?
> > And what is your qemu environment for reproducing issue?
> >
> > Thanks a lot!
> > Joey Lee
