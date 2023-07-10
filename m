Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD1974CED4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGJHpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGJHph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:45:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2138.outbound.protection.outlook.com [40.107.237.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAAF124;
        Mon, 10 Jul 2023 00:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/5QcPu+EdVUJgi4MwUsdeB8yfBQUnbjzo37M2OeUVSKDA2FgCrNuJeoCKf9pF1CFMFQ9QXfUrwWQgbNXV2a5vksfM4/uyJIHhOOVzYN2bHW4MVZQrGrmqEQ5NGfJ4KkmhJRgVLetMhdF43zpsTuTYI3bSKNzxlIRL7iIUp77s1GtYmMELl244eT2QaxGAbtt7V31psaEerC+J2ORy/AlkIqp0PVOC4T6nFCjdPcauCzyz94aKcejiY3vya0ZL0R73B7tvA6vrmYHeGZiyhqr+9Yo8GUCjNM7VyTAyX4TAEWYOwY7wvBPcR+TfhbgydTcPm9vXfQYROT89U875gYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWpcltkotsY6FLH7nZTUJnX3ma5ZrMzxwgSa5tGYj4k=;
 b=VljulGHL32ltDx5dalUYbjre5U+Iu/053g/GYtcasfTiapW/97wbic2BLC60wk6IV9X22hupF84MsrVSAKB13a71vT6aHHau3mrj6gtODutirOdN54antlg1hqOCBjJIcwMpeU7v3VMI3sxIS27nBkRZr4kK+mUuuIuZSGVRjteeRrPMzyeyMGHneOiMvhuzGbXfCfMwXP6iKisyt5bXq5k5VEH8F2vneicepWm7WERykMdGyrbsXSzfdZnLTN2avMO2RlN3SfGpuhRH1xyLy5rTmUWzRUI0xsUpK1Xm8baUCjGaSjw8tiCht2QpoGv4wCCWn+9kErLtCrSRJBmzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWpcltkotsY6FLH7nZTUJnX3ma5ZrMzxwgSa5tGYj4k=;
 b=FA25gRpjsBHjh39zQ+WdgK5LwxUeveElzF5bjZT1AEiDkoq3xzPM/iiNWQ3+Fz1A2dIelxj29DXr/QvVUaKZG+3HeiBNgQ7GY4015skwc9esUHd/yPK9BHENWUBTWsIbKZucmx4bvsshEguIhVxHSI5s46Pb9sdD+HlmbMvSrEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CO1PR13MB5063.namprd13.prod.outlook.com (2603:10b6:303:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 07:45:30 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 07:45:29 +0000
Date:   Mon, 10 Jul 2023 08:45:21 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] s390/ism: Fix locking for forwarding of IRQs
 and events to clients
Message-ID: <ZKu3EVOANmy4KaLZ@corigine.com>
References: <20230707104359.3324039-1-schnelle@linux.ibm.com>
 <20230707104359.3324039-2-schnelle@linux.ibm.com>
 <ZKlmeDUEZf7F8+HW@corigine.com>
 <df5fe3d295711666bf170d35f5196fe7b880342b.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df5fe3d295711666bf170d35f5196fe7b880342b.camel@linux.ibm.com>
X-ClientProxiedBy: LO4P123CA0265.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::18) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CO1PR13MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f19ca85-8cfa-4a1e-0869-08db8119a1bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMmO4WJEf39mJX+eMVd0fzGjPL4OyFxZqxzYewryaRj5GlvjvMkWAR+WwrkqujeMFZTL2iK+Psqby+5Sfxt/mwj6u1NuyY6HE4jWSIrP0fy+hcCXPdfNJ3pyvwz2Vck8nbXY7Kt7tHHXOwX/bSdMKwYPSr+hA3WIi4VxNYHlLRc3ug5xQvvdzVCMkCfNRgjNQ9ktDs5A0veWJTO0TP3Nj3C7vV71LNxIJ28p1YqaiQ+8upwJViy2OJrLjFciK9XUJz034Aa/KTb8vuGrgzSLhrK2+eiZ+JH9Z+8D7DmOp4LweppWAMnhCfpUPLzJqFrzBYt237NzdffFHmCsTJc31cSuvWzerie3wcVOuxPMuvNFJyHxJrfxDyVpzJ6zx5iTUuB9rE9CpqCPX7Xrj2B+oIg4v1vfE6ds8jbb+8pX+MCeGcc1Aqo0xRXqje9YB4YGvOIgIav31/rtum+MjTJm2e1KHzc3EJnQRBdflMAaoi/TbtvYCiwhSSSApWTnrDP25XL5cFst4I0fvp1TUboF8zyiMzQ5YKn+1ifXq1rd3hU0UtTU/qmy0Sl0LSNzK/mHpEgtPU/Mfw5ZOddQIEUbO4SDEXbW8wP/NYc2TmeQeR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39840400004)(346002)(376002)(396003)(451199021)(36756003)(86362001)(38100700002)(478600001)(6666004)(54906003)(6486002)(6512007)(8936002)(8676002)(44832011)(5660300002)(7416002)(316002)(2906002)(6916009)(4326008)(66946007)(66556008)(66476007)(41300700001)(2616005)(26005)(6506007)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jn8Qp73JtLSrVOM/bZvt3TYKUgG5xHtu3Zf4sLmSYKV8xGsPvw9CxPOkm905?=
 =?us-ascii?Q?keOqEw6EmC8/vcpq9zUMxvtIOfmH8Fnk5vME8f/jZxb2kSUtE+92tPrALa7V?=
 =?us-ascii?Q?RsFRT5y+ui5zsDRfvblYbeweL0/6bWJLQLtOhljVOimgY67mWafJ0yZq5FSj?=
 =?us-ascii?Q?imU0oi89VrZWs+IUDFGbkvBIjutpiyKvApPWvQtV0Vp3CfRoUGtF99wbuw/M?=
 =?us-ascii?Q?9nUF2pwR4Ntp1YO8jh7VtxABLHU/L809zZU48ewzaiH7RpsXO/PgJJcRVmfF?=
 =?us-ascii?Q?bDbfuVvEyFELWLDlF7xDhXeuye4F3pUFNWnxZL2NVokWYbnBMiL8+gHKy2gq?=
 =?us-ascii?Q?+Gt/IXXeybXgG1XrOeVhgV2MM32G18h2kNnOXaD3PGmdwMLCZwfr4I7pHqB6?=
 =?us-ascii?Q?+lF/nl+zSFDX38Kt/G9VRQsq7tBxJvc4F3I0YFmBH92VXrjIBv0rFODHQ95N?=
 =?us-ascii?Q?sVe5AYH52PLd5RRTTHs5jX9W5/7e+4x512yC80CR6lJxbvVAgBqopL37fAly?=
 =?us-ascii?Q?gs882KpUSHvWPsyncM8hbsOKUIBpK16NSfMFg2dfD8YDCDur2oohPCJSFl0B?=
 =?us-ascii?Q?2hXJq3KeAeWImj5nRcMIK90v6SpmJc6JUYjQuNn78q6mYZNWddcEQP0BnJpM?=
 =?us-ascii?Q?rFAE/vUDDLwp7wQT/Kd0QsWKD+FG75vmg3ih96s/vLd9rvOOSIYRC9tMngtH?=
 =?us-ascii?Q?eKO72Dx3Mc+eoDRyZqeWZB1uulU9G21gZzw0omvSnhDo6lP9t10ZyWcwjH9A?=
 =?us-ascii?Q?nS7MvRUtGEupgmGxCsU5YV3LuzDghjJBk2oDZKWAFChudXWjSVO24S86F5Iw?=
 =?us-ascii?Q?EfI7BFqw7EnmaIb7Bfrk4TsDB+beyJkW6ucaBZenNRLq+cMPF8m/gPpX7sJQ?=
 =?us-ascii?Q?YdtNb2zi02UDWC1k5f3SRrHeauCzoNRZGsGfd6qla7YbWlb32bBuailSL5+8?=
 =?us-ascii?Q?6b2CrWFlqCEEBRmnMIxIFEccrcVDs1Gf+5P+8S39YhzWZGaUom5NUpI8EuyE?=
 =?us-ascii?Q?1xLEBgqFVR76KvyGy/pR1YNxojYme1ufNIVwrxKoKrZlrsmvSWJy/lbHO49e?=
 =?us-ascii?Q?1tkk7qPdWyPIiOckv2N7khVRI6089hbcQbuhWaRli3pKrKsOgnOuyI2k5Wo/?=
 =?us-ascii?Q?zf2GtPYMsFJ0jnzXWOAFCn1KdRzI9NgQcHmHUjhmQVhX2RUlRbaVMyi9z36l?=
 =?us-ascii?Q?IVq/V6EMYWfqcH4Mgyt9St0g6PREtv+pZDNla9PeCqin9GgY4Yz3CqmZeBWk?=
 =?us-ascii?Q?kaVzIzA1Ze7S/Iwb5EV9D2tw+3iUPCDcOYPrwP6Gg/rMcFk/9kvSh+qJYmBN?=
 =?us-ascii?Q?Pj4Tb5NNgM8deZHRYtq69hScwW5WbkHlNjQ4Las9ZeAhyWWEQ1EaG3fKt3kj?=
 =?us-ascii?Q?2VOUouzsKAlv86P0SvUIVm0ccTd3/JzREYQC3MZVPfBuOkG5vwj0RYqUAGPk?=
 =?us-ascii?Q?ZlPIUFshK87k2ngGM3oJJ96+Ya9WCE5+nuUzBMOiXxkgFH6YlHo+IW/DMoKb?=
 =?us-ascii?Q?RkIqaG39lH21iHq5TLkWbhV3WNFGtyy0PvjMA+0gbQ9TlkZ7feyKVVCLzTWz?=
 =?us-ascii?Q?1EAwDrL8nU/t6Ek2RwErArQyK+2DAT3HXfXuuav/fhXqEblO1lhi2rQfaml3?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f19ca85-8cfa-4a1e-0869-08db8119a1bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 07:45:29.5078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrK3gwaqjrjo2fqmad1Gl9WANUEWhYhZiUPG4jjR+YHbYWXSL8uPkG99BThPtr+xU2/P3tI0u6WQWVDWpBXY+jQBByYX5DhMmveSZ1B5+XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR13MB5063
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 09:28:20AM +0200, Niklas Schnelle wrote:
> On Sat, 2023-07-08 at 14:36 +0100, Simon Horman wrote:
> > On Fri, Jul 07, 2023 at 12:43:57PM +0200, Niklas Schnelle wrote:
> > > The clients array references all registered clients and is protected by
> > > the clients_lock. Besides its use as general list of clients the clients
> > > array is accessed in ism_handle_irq() to forward ISM device events to
> > > clients.
> > > 
> > > While the clients_lock is taken in the IRQ handler when calling
> > > handle_event() it is however incorrectly not held during the
> > > client->handle_irq() call and for the preceding clients[] access leaving
> > > it unprotected against concurrent client (un-)registration.
> > > 
> > > Furthermore the accesses to ism->sba_client_arr[] in ism_register_dmb()
> > > and ism_unregister_dmb() are not protected by any lock. This is
> > > especially problematic as the client ID from the ism->sba_client_arr[]
> > > is not checked against NO_CLIENT and neither is the client pointer
> > > checked.
> > > 
> > > Instead of expanding the use of the clients_lock further add a separate
> > > array in struct ism_dev which references clients subscribed to the
> > > device's events and IRQs. This array is protected by ism->lock which is
> > > already taken in ism_handle_irq() and can be taken outside the IRQ
> > > handler when adding/removing subscribers or the accessing
> > > ism->sba_client_arr[]. This also means that the clients_lock is no
> > > longer taken in IRQ context.
> > > 
> > > Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > 
> > ...
> > 
> > > @@ -71,6 +80,7 @@ int ism_register_client(struct ism_client *client)
> > >  		list_for_each_entry(ism, &ism_dev_list.list, list) {
> > >  			ism->priv[i] = NULL;
> > >  			client->add(ism);
> > > +			ism_setup_forwarding(client, ism);
> > >  		}
> > >  	}
> > >  	mutex_unlock(&ism_dev_list.mutex);
> > 
> > ...
> > 
> > > @@ -92,6 +102,9 @@ int ism_unregister_client(struct ism_client *client)
> > >  		max_client--;
> > >  	spin_unlock_irqrestore(&clients_lock, flags);
> > >  	list_for_each_entry(ism, &ism_dev_list.list, list) {
> > > +		spin_lock_irqsave(&ism->lock, flags);
> > 
> > Hi Niklas,
> > 
> > The lock is taken here.
> > 
> > > +		/* Stop forwarding IRQs and events */
> > > +		ism->subs[client->id] = NULL;
> > >  		for (int i = 0; i < ISM_NR_DMBS; ++i) {
> > >  			if (ism->sba_client_arr[i] == client->id) {
> > >  				pr_err("%s: attempt to unregister client '%s'"
> > > @@ -101,6 +114,7 @@ int ism_unregister_client(struct ism_client *client)
> > >  				goto out;
> > 
> > But it does not appear to be released
> > (by the call to spin_unlock_irqrestore() below)
> > if goto out is called here.
> 
> Good catch. Yes I screwed this up while splitting the patch up. The
> spin_unlock_irqrestore() is there after patch 3 but should have been
> added in patch 1. As far as I can see all 3 patches have already been
> applied, otherwise I'd send a v3. Thankfully even in the in between
> state this error case can really onlt happen due to driver bugs so
> maybe it's okay?

Hi Niklas,

I also saw the patches have been accepted after I sent my previous email.
So, given that the problem is resolved by another patch in the series,
I think the situation is as good as it is going to get.
