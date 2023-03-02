Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3946A85B4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCBP6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCBP6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:58:36 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F210D43456;
        Thu,  2 Mar 2023 07:58:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7TY6d06tWlhw7TpFz5C8tafsDZP4pWUsTOvuTENPWEqRbNq6VY2SZma2HBE9QIFekadxswiaZXRRfYoEspbhNF9/AEdqmjtdctAcPDsQvPH8vwyuuZb0LIJ+BSjTCEXxYhUd1xp87hVr0he9OMPsaT2gOjFtGATO5KSOQkZXK/wXwQw6QXwvhrU+4G9XfC8HllQwhzSDeGxJPlwicsdXLF1IBA/p2KxswKhdIlVy1gdU3Q9iUcQ0arJsZUsdF+kASh3zQ3HPhkeMsPMmmWeHSaMo875+v+Pr/Fn0t21wpGy+Gkt7KiYAXMxX9LFhQ7OWxMozdKG4xqaIg/c3vmOag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYL6J1bq/JlThP/xlWuKssyXrfuUN2L6dTeB7BGrN0A=;
 b=g49osrKmnb+sx47D3v1WuinF4j6EKaOkcU6El7RPpQRpxKSoUCcWpbXsD0LqT+dbbvtd4L9+SOR8aB0/vq0YLAYFhUP6RxLv8n6Ey+r7WK7TDJXaCgdFs27HajNcF39TFJZW3XOohn3qnV1kky/XxgOxw2MsQZpX7e92FV213x2MQ3zonK9Gn3pvKcJrOPv/ORwprsXTNZEIN0KdNJ6PAbJ1RMyJlpXlGXqxy4bxDnxSFrG5ZZ4UYRJcMoC28zU8oMANjt5BMr5sgLkMb8J/vfmDVM7NxniRC4EzNRtX98kVrqv3y96XPM0ebBdrrvNSxyOTnLIm73RX40KPezHuRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYL6J1bq/JlThP/xlWuKssyXrfuUN2L6dTeB7BGrN0A=;
 b=OG2o5QodBuSw92CdaJUV1fRBJRcqF413fS45WCABB9sZBSRyRVwKsPc2eTev21329O3kRJT4WXTpTsagmB7t3ZHeh3YwEIgVdiMfdlyDdHv7omiEfmElMHtrP7b2leTbZWPq1SJ6LShF/qyyrDKw7QgwN4ZXTosvaJQvYVpx5fuqejOcgBaM8iiyW3x9jjH6KqtYjnIYdQGVwCCukdX1r30jzd0z4M7jRk74AfXKisHf7dKciURB//QDmPHPsj+WBRmH6MXTGdHDpC1mEIn4HJHERWYy9cPtzvopswHqcy5SQYs1+FqycMyRZVrpuo+e3OnTs2RZzbBUJx9FPblZ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AS1PR10MB5650.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Thu, 2 Mar
 2023 15:58:32 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ee44:171b:4c40:d42c%6]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 15:58:32 +0000
Date:   Thu, 2 Mar 2023 16:58:24 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 2/3] leds: simatic-ipc-leds-gpio: split up into
 multiple drivers
Message-ID: <20230302165824.4868f6da@md1za8fc.ad001.siemens.net>
In-Reply-To: <ZADE7kBB9HzTlpul@smile.fi.intel.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
        <20230301170215.23382-3-henning.schild@siemens.com>
        <Y/+LLICwh3T25IGv@smile.fi.intel.com>
        <20230302094009.74b5d368@md1za8fc.ad001.siemens.net>
        <ZADE7kBB9HzTlpul@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:610:74::6) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|AS1PR10MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bf46d0-5276-415e-e3b0-08db1b36f925
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0UA9oaR2qRiCG4/oWACVPiolRJtVbJ9Gmh/p8WzdiXTV7/82ewTGIFCMdsJOByYE9rwLF0RtLWZfs2G66aAoi/fQ+/CBdNvDUVQ/aSrgBqhVRHAjOu2g5Zlnrm/uLBmJT9f/nzjTm1vK7xJ4zjFjCqm3ia3Fzbr455MmYCSyUTuuqe/Ss3RPtdYk1ArRXpjhja9XXQQaBXlYxiALNhQsWujp4L0I4xsBU90uZRGdXhFECIY+bi235jqikDVBCmzpr8S/6Ckrj/+vC5wTH1iWajhu9oWx+Z/NJgFuUoHjUEaPirqz0q8gUqLg9B5/SXq1PQfLXInGAXHWEh+/2R2PMbhJZLlXUruQFVIIxjK4WYcGlHVjhMTOw6oB5C/YhAer5BE41k8pe+RY+5232MCKER8jdyusT0ctovJM/0+Lv4fGk9DCbm6DpmzPs/y282pHfoT5vvkC8n1hmCYQb9URW2iPTvg3uyTEiqin2/6mVHXu3+M0o3vu7qJQaI8Y9/vTAJWWvpZMRmhY24TtgLI+24l2T5zcSsrFgOG3suBXpysQDQjPdhoMpMTcs5Wl8HCJEk/AaYEtrZetoOymedQ+1HtZKPWCKTwmR7xgH+RtR6HKZ2EHqr0jdAOUrOof7PXlpz/+dXSYOwtK0qJI7EPmZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199018)(86362001)(66946007)(478600001)(8676002)(8936002)(4326008)(41300700001)(66476007)(1076003)(316002)(6666004)(6916009)(54906003)(5660300002)(44832011)(2906002)(9686003)(66556008)(186003)(83380400001)(26005)(6506007)(82960400001)(6512007)(38100700002)(6486002)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVJoUG5JY0ZmZWNUUTFQbFFTaUZ5SFVVR2l2Tzdlby9xMGE1LzRiRXZoM1hE?=
 =?utf-8?B?WmI4OE5Ja21TZGZxMEZ2ajRkcFMvSDIzbnhsV2hnNWFtdVljdmRycDg0ZEVu?=
 =?utf-8?B?QS90VHBoVm5NVnFiTW00dktNMUVNV2NJaDFLbkpuaWRnd01BdENRQnFVaVFZ?=
 =?utf-8?B?REtNOXAwb3MwOHQ2cFRsbnAzdHorQldNQmhxQ0diS0ZPOGFGd1Ywc2lTd3pq?=
 =?utf-8?B?TEpQcmlKQVJLdnZDMk1KSnZ6SUlrcnZBYk1tcXNUYVNpY2k1VWNHcitRTTRV?=
 =?utf-8?B?cFFYa3U1UXhYR05tQUFYNXBrSFRHMmZTT215THh4UGs1RUJGRkdHN1hjQWlU?=
 =?utf-8?B?dnVsdE50RkNibUVwT1lBYTBtOWw2M1p2TjU1Z1hUNXhVbEJiS1VQOU9MQTNT?=
 =?utf-8?B?V3F1Y1lPQWlNL2k5UEJFTzk1Q1B0MEZ2WUxOdlVvbVV0Z1Z1YlVKdDUzV1lv?=
 =?utf-8?B?MkphVjB4MFpOUHhad0tuNmJocFBDbTI4bm1SeDlwZFF2L0RrZEZxRGowRTdV?=
 =?utf-8?B?K3BMNFJTQmlQOG4vZExtSXpjMDEvK1VyV0lkODB5Nk5RN2g2WUhkK21QSjFH?=
 =?utf-8?B?NkR5NTFGNXFKOXdwOXpBUW5PZmdIdmc0VWNRdG55Vis3S0FWME5yVzhzYnh0?=
 =?utf-8?B?Nm51WS9qdlh6L3pySHZzM1R5UUJkRVdTNmZKeWhaN1ZDdG9NTEVqZ3duZFp5?=
 =?utf-8?B?NWlIeThNNFlNTG5WUHZlRW9zUFVLaGFSQjRHcG1aNEl5UTIyMkk1cG0vbVNI?=
 =?utf-8?B?TTZjS09EaGRYK0V3djMyRE44c3lOayt3bHcwcm90RHNqUFp1S2dGN2xudTh2?=
 =?utf-8?B?OVZqRE41OGkyYSt0N2pFWVhXSXZNT3g5ZHBnMldJM2NnKzU2VERmUXhCcFNW?=
 =?utf-8?B?aitQUXVkU3A4T2xod2N1S0JNWms4ckFJejBEdTBUNGRXSVBtNURNeXhhaFNm?=
 =?utf-8?B?SW5WVlRpWUpSMkwwNVlQMEk4SytWN1I3N2ZIUnZQcHBNejVpNHRRS3R2U3JE?=
 =?utf-8?B?aUllZXpTbWRIdWFYQ2RFRHhxNE5ld3lQem1EcW14Yk9ScjhPV0lCWnhpRGJw?=
 =?utf-8?B?d1djU1VSQXAxMXpTeDJEMnJka3JMbFZBbHBOV0U4NkozVmw3SEM3cjJ6eGxD?=
 =?utf-8?B?c1NENk9oVkVER1BXU095UW1yYzA4Ly9xWnVDSHM3WC9UTFhleURaNlEvZFJN?=
 =?utf-8?B?NW9ybmppaXJUbkJMUHlzcTU1RkduL25KTVVNWkhoVTVPRi82TVRXblQ1Ym52?=
 =?utf-8?B?QkZpVjExU2VaNkY0WmJpUWc1UUt5dklaTituK0g0L1lVR1hnaWRwYU0relFt?=
 =?utf-8?B?R3lHc0lzMEZDaHZwWk5xeE9BZDVwbmsyRm9KYzlhTW1JZ3BrVGxwVGYyMzNk?=
 =?utf-8?B?Zmh5aXo0dkFiYlFJWDlua05WcFJKbndMR1E0NEpMcUhMeEFKd3VzT0FRREFM?=
 =?utf-8?B?SG9MblBHKytVUUhicDJvK0RnbGxvamhzMFpzeWlQa2NIV0ZUUjFCdTc4dzgy?=
 =?utf-8?B?RDI4TGk0WVUwNjBCZVFqZDNKQnJzWHR6UUF1cnhtc2czYTloVXA4eGNwd3RD?=
 =?utf-8?B?VlhUM2Q0V0QrQmNETmFKUjMram11MDZvc3AvV1RvcmFGZWpNK09pUkxoY1FH?=
 =?utf-8?B?WTFSanp0cGVIUDgwZkJ3VGR6aGZtYnVVMkpJN29UK2NPWndDUFJBazZjemsx?=
 =?utf-8?B?aS8yRzRKbUt0aGFHODZMNTFIYVpFcmJDUkRNRHdXQkdMazlFdUU4WHNOM28r?=
 =?utf-8?B?RldFd2FHS0YxWXhIRHBIbXgrT2JqNHIwT3FLQzBBNXJDYkU2OFlMT1VYMDhL?=
 =?utf-8?B?blBqWjVLWnY0bCtZYlc4ajFGS05ZQ3F1alFjVTNHbzl0cU90dEdWUkZybXow?=
 =?utf-8?B?UnFCUGRPNzB3UnREczRaKzRadnc5dzMwb1B0NFZZb0R5Z0pHcDc0bENQZDlj?=
 =?utf-8?B?Z1M2dG1MYkFWNTNqK0VPY3NuUTd4VGxDOVplUWx2QWw4Y1FIREN3MnJBRDhx?=
 =?utf-8?B?N2JsdGpOWXBqQkN4d3Zlb2N6R1ViUjYwaTdseVZJMUtxMXh5WDd6ZExJaUVW?=
 =?utf-8?B?OHI2TkE1MktwTnhGbkNVdi9sODkwM05wTWVaVjI3allLcE5GTk9iWDVnNGR5?=
 =?utf-8?B?TkIxNjVES1BiQWFwOVY4VCtUK1JlN0RPL0RSUFVxRGRBbUs0ZW9EaExGNGhv?=
 =?utf-8?Q?cbI+bpx55T/OK7Dr4+0oISw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bf46d0-5276-415e-e3b0-08db1b36f925
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 15:58:32.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giJcuOU2/mzUo8FPdWfI4qguPNgDlJQPfXl/XEbPyEakOK6a1aIH0NHk4K3qWlMf3NlkTeGQr9X22L6+HFSYQLuJR09/oJ7pKBw5I6K6zbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5650
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 2 Mar 2023 17:46:54 +0200
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Thu, Mar 02, 2023 at 09:40:09AM +0100, Henning Schild wrote:
> > Am Wed, 1 Mar 2023 19:28:12 +0200
> > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>: =20
> > > On Wed, Mar 01, 2023 at 06:02:14PM +0100, Henning Schild wrote: =20
>=20
> ...
>=20
> > > > +	.driver =3D {
> > > > +		.name =3D KBUILD_MODNAME,   =20
> > >=20
> > > Strictly speaking this is an ABI (as something may instantiate the
> > > driver from the user space or elsewhere by this name. At the same
> > > time this may change with the file name change.
> > >=20
> > > Personally I prefer explicit string literal here. =20
> >=20
> > Switching from one module to three the names have to change. People
> > who explicitly loaded the old module which supported multiple
> > machines, will now how to load either both o=C5=95 know which one to
> > load. =20
>=20
> Wait, are you telling that now users load modules _manually_?!

No i am not, the modules all load automatically. I was trying to
construct a hypothetical case where the name change could affect users
doing unexpected things.

> > I personally think the ABI change is acceptable, the assumption
> > would be that the drivers load automatically anyhow. And since
> > there are no params i doubt users will have /etc/modprobe.d/ or
> > /sys/module/ stuff around.
> >=20
> > And with the split i guess an ABI change can not be fully avoided.
> > Whether the names is explicit or implicit is another discussion and
> > just a matter of style. I prefer to stay with the currently used
> > pattern, it is not un-common in the kernel. =20
>=20
> The problem with that pattern is possible, while unlikely, renaming
> of the file which triggers this to be updated.
>=20
> Under sysfs the folder will change its name. If user has a script
> relying on this, it will be broken. So, I prefer mine.

Yes, the name of the module will change ... and the location of module
metadata and params in sysfs, both not a big deal here. Because there
are no params, and there is not need to modprobe manually.

Henning

> > > > +	},   =20
>=20

