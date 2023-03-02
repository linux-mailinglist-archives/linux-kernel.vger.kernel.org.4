Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744D86A7FD8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjCBKTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCBKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:19:22 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9484F126C1;
        Thu,  2 Mar 2023 02:19:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3l9wloEKJqYT4QFFt8h2Ww3H3WdfSp/gQDwa2PjtjK6yAnWY3uPVe77v9YQeCOSVdfHPv4ox/9wOPKWNWLTPiRYAgpqK54Ja7cxyND6GyFwn+K20Pl9zTy2nB/kei4Pvnx/pNijolxIkQK5YGEupSyeG2Is33O3KoZvvrZqdygzmGHyaKIq8orSHZUh0Y4b+Bfu2oWSNa/o7XzR1VEX949u+XRxQvkBTX43tJ8LUSvuqHiKUPyR+nSdyt6FNOXoQdFfcEyloEsB5vkljziX2nsOyJSJQeXklv8q+pVBo25wd8J9NRE8V/fxhoBob2UgEK2j/WO1DRWmLjkD+BOgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt+m61CpCk+YNA80zbxeE0ifunwqOY9QCnJ+ipFGDf8=;
 b=aHjBLaSlGSqzWqyOw8uNQG+TI/V4/reO2v9FZHvXZwWVSJqrYKUbkFCq8f22BSI/iR0WmyG2vWPYxUih/XrjCb1TivIhEy65fM7lwvFcESgC5OCjUOMhPwj3hJ0/E3hCt/wMpn+CzlPpAxYfulKq8NIvCOJitsBqYzfsoJgyEDdIOzhYPcv18y3INspNqAs8tUhIU2TF74iWhqIvnpCDgfnIUaOHDwAqNc22SKJ+o0vf+6UsEfw2XW+9PdbSmGdLOSvj/kKoL1poaW2xVf7ILsFof4HT7LJ4NAptDK5V71bdbu6R1hKzZ3AL2TNPhAFg+0fytv82IXOMlOEB3EFNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt+m61CpCk+YNA80zbxeE0ifunwqOY9QCnJ+ipFGDf8=;
 b=Fv4n5T1T7hnNbjdKaG63Z0LuW4xJiDaz3yJN/rl8LmqK+pIuMZ6VztEik/4KGChwLFonjhuHmyTJnmzoN0Us5uONq4vyqu7boLUMwExoVjVbevfW0lAt8n5h+yCWioWwrpsiTQ9C92GOcJeOkjWBlabT9LiBbAAJJalOBwmoP2azt6raeBi1mOtDzuXwl3qlVW6tcuWn8QmqXFfhTQTUqjTR7cvLEAMDFpM4btr6GYK8yFEoxW/mrHDamB13E/rmawd3NsLsy51zqyp5JXY7xxA8rp4xnnDsaWcmtIoKrgOGcKWOzmiFAjDUoagOUrhY0EGW3aMONecoGJqLFqNtwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PAVPR10MB7418.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 10:19:19 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%6]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 10:19:19 +0000
Date:   Thu, 2 Mar 2023 11:19:09 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 0/3] leds: simatic-ipc-leds-gpio: split up
Message-ID: <20230302111909.721352cf@md1za8fc.ad001.siemens.net>
In-Reply-To: <Y/+Lvq36nIgIcAIK@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <Y/+Lvq36nIgIcAIK@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:610:32::17) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|PAVPR10MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: d88d2653-b708-451a-246e-08db1b079580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQEHljtjq7SIf9vp2HWNiRDKtxavtGwXeqiaDmpxKReWWKoaEC3D9VHO65RHP1PCIzftG3t0KYbepBhOYwq9b+DnQ9BygQwKznaSSGHaXjOUS/LD+gpN4MBRWewCBotKbNfoI2F+o0Nc2Y4yAFR5/YK8ahgU2QxGYR7LK8G1xh347HGQQOwdar+WBaam7qYNPH9dNp2M1i8rnqkyhmE16tVFek2sNQCuL4YU7+D1Cvy0vcwTijZ24j7n7sygIWEcfFIojwTTb7xPPvyin9ttY2LZ1NOR0X+mzcoaqimqb99TEMrpjI+P37sYUF43Wri4VGFsRniEhEo++FfGD8v/4GhGY30GoVyLexMsSQgoo9vgoDLJiJ+Ng6LXGQ0/0Z06hLwH073vNsl7045XPMRIUbPmnYULbLTEBBOWME79QUypVc1TGU5LhQ90iFPi8YW+KNifCgNpz1n3CN9P1/iMtbmXxrvZdvGpKMDGhg7uJcnsjg/N8+bhxzPy7H1xmcZNvZmpCkCjbtR/yfHDLyr22bA8O2SanU6l+lt9zqGWjWEP9kZ6p1oaaGubAh0Ws0hF/ZMMIHajSfj3VrY/m9uAUlc/BE2XSJ/Iy5HjrkmUHLDrpBkGDW4f59I1SOIZ6oyLbNQEyrTXNOox0c0uyvAuvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199018)(66899018)(83380400001)(54906003)(316002)(82960400001)(478600001)(9686003)(6486002)(186003)(6506007)(41300700001)(6666004)(1076003)(6512007)(44832011)(66556008)(8936002)(2906002)(38100700002)(86362001)(26005)(5660300002)(4326008)(66946007)(6916009)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9lst1EbkVexqH1NyBaeeeDiZppICSRAlQBXcLWLXv/pVOWrJtZVMg0BFUiYO?=
 =?us-ascii?Q?wwi2Gc6dadrpU0CZD5m7v11/SzosX3Jf9dRfaIm99qc3BQ86iihGMGFyRnn7?=
 =?us-ascii?Q?pasvgleap8syo7I+2A77euNLNS1Li2k1Mw31wZ7crmfb9VOnErMrwov4Uvyj?=
 =?us-ascii?Q?WfytZpfZ9rm5ZFua1qptktw+gbrc+O+f92DFsLagXTLovg8UxwSfSuiApTrR?=
 =?us-ascii?Q?Tw/2ovAdHOZ2vRpjrLVBy2RzHHVAYSIQOyy5vwP3W0KfqdZxVftNWByujd6A?=
 =?us-ascii?Q?yry7a3ZHCJsXae+vH32Xufm+txp9uJT1m0WYwgzL76nO5AldZQmdgjcb9wKK?=
 =?us-ascii?Q?Stc5i0w9qEKj1H2zf288IbXRcXP37rCIpFRThhed/Pj8YqanCnuHTxyhVjvI?=
 =?us-ascii?Q?xyxBKhNNUUyYEY7JnzjDf9MdQ0jHka3bns8oqx1NP41o4dlx/gxEcqgEJ7lM?=
 =?us-ascii?Q?zFBS5w7alzZsVnKh5KoIjsiMaWD4uRvJEBxdZtO6LKEsMQTSg4bWpU4DDHyp?=
 =?us-ascii?Q?xNpdBLr+zFtwrwhW6ORzn7U7O9b/y6UoGX6tb4D7X8VWfIYM7n05mVaGUPIO?=
 =?us-ascii?Q?JEMJNtY9N5p071r9eiM/DXH7xfWdXWRQqySIzmtaBdGgNL0qGfQ46hjZgwoX?=
 =?us-ascii?Q?EOwlA2aCCjJBTCj4DVSyIyXQi5pFD7Tau/jDmUWyznNP3hEOfpgFx4fau8L6?=
 =?us-ascii?Q?d3fa9fcM5zFzR643p7h70BT+dWALn2hB0Te0mafEGIlnoVCY7J48HbLfLDuO?=
 =?us-ascii?Q?n3zhGr7fMHd/0oHrbGM7Q6XZOJ4A1jgoj/L793R7m840t4uhiXQiCGKn0q6T?=
 =?us-ascii?Q?i93bLRSn15gFeS9kEc5Te9BUSGIPiSYdnQtuhxV4WHCWVr29oA7sB7eME5bV?=
 =?us-ascii?Q?YpDPNv8aZ519fjUTgB5/Ck1Wmb2YS/9S/nfnNh1IwIS/1VwjzIt0SyEM6Cwl?=
 =?us-ascii?Q?i98mWHOC0LUJIzdUe/b4gtKCw+a3eOGvCe7FctA8pz1r8ng38AMEiRXTMDsb?=
 =?us-ascii?Q?s/AHsLj7R1PSZvpbRSX1KdiJkys15NT9gFL4LbJ5iVmMcoU7NcLc64c5XjJW?=
 =?us-ascii?Q?RwgPHN3dWKxwayGbgFBTBkmHEo68Q+B/LprwkREUBYEpNSDBb7JEWbhZIUfX?=
 =?us-ascii?Q?yP/348QENuS8zA5wy/SPgk+8EcdX+63vtnITACwL7H3zCJLodTREYaUEi3jN?=
 =?us-ascii?Q?bL3NhR4cJ+i0AwQzPAcwuaUAp+Q4trhA4u03MQf/X5RJJy+ZlupkiCsPao7m?=
 =?us-ascii?Q?9J6iREEIqwXTqjKxPngD8w0USf4+XTJ3UsIWOiyTsyeBQx8J8GjGR3+YaQtm?=
 =?us-ascii?Q?+sYh9/HyxuDTH49zPXi3MOWhUS6BO0hw39BTyO/LU0zWMNs3JhfRky+D4x5x?=
 =?us-ascii?Q?A5FuSspW/U1ltdUaOdYq+H9jKgOHI5JkFp2EpJiim/YVAQ7fPOcVgcBtXkEv?=
 =?us-ascii?Q?iaOIJO3o8EmOJ1Qo/O/Nz5iokqRq74Ra4ds2836xrDGT2htArhNoApl8Gz4Q?=
 =?us-ascii?Q?sTGox5Mc52uhR6JKNbgohfV0N6BfxhLsNBUzrGU4p9l3wLtDR+UDuL3Kti+9?=
 =?us-ascii?Q?ONLhVI2Ecldx57xavBQLqBPlCe7nJaeeuI3qgpzPMOgm1WDmph/g/9gyxkKR?=
 =?us-ascii?Q?43pdN0fo1hZryxrZDdN8Xj8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88d2653-b708-451a-246e-08db1b079580
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 10:19:19.2323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjV8O3OZiDIguhgFimro1j+dj64yM/I+mr1KuefcVcXnM2ExHov8qfiT8Oe3/FgpWuAVweVcDaydaV6qp3JQ2MqltB+9hQABkCd4RsUZPdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 1 Mar 2023 19:30:38 +0200
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Wed, Mar 01, 2023 at 06:02:12PM +0100, Henning Schild wrote:
> 
> > This series mainly splits the one GPIO driver into two. The split
> > allows to clearly model runtime and compile time dependencies on
> > the GPIO chip drivers.
> > 
> > p1 is kind of not too related to that split but also prepares for
> > more GPIO based drivers to come.
> > 
> > p2 takes the driver we had and puts some of its content into a
> > -core, to be used by the two drivers.
> > 
> > p3 deals with more fine-grained configuration posibilities and
> > compile time dependencies.
> > 
> > It is based on
> > [PATCH v4] leds: simatic-ipc-leds-gpio: make sure we have the GPIO
> > providing driver  
> 
> Thank you for an update.
> Not big issues found (except maybe the Makefile).
> 

The Makefile does work with all Y. So if that was all that was open,
and the rest is just optional improvement. I would be happy if this can
be merged as is, and deal with improvements later.

Thanks!

Henning
