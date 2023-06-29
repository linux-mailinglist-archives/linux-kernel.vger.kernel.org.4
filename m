Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60989742DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjF2TZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:25:44 -0400
Received: from mail-dm6nam12on2119.outbound.protection.outlook.com ([40.107.243.119]:27873
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232394AbjF2TYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:24:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZX4QYqHLNL+EmeuICQNr7JVo3IOHBr9jYahLaIbKGvt0gn14FTf+BM22xRFbDL4/v5ZIEGnUnzcUh3uxzPqgY7HjjPCkf57jzCKbjz8swDds+MyBDenNIhr4WWT2ZfUAFROGDUaNXPHa3urQ3JOMGnQ5mzx6hkjjBFfIoyjlSgNk6Bwqr4QxXYxT7zwK8fZ+Ggra0z2wHTLh5XqtH5hV4GmMjpJxeoLKTZ/709oUxetOA44XqqTDwz42YOP630f0qJ2wgmo4PLhToDTpYfByB2SRxYuGtUQ08W3iTT0Pm0QjNL8NnmREuC3JA1CjDL1V3Q8V5EYcZuhpljhIuhEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qSUq0JYh32zXpbuOJjFm2JfJgRqI7+ySbhSmoGYkrA=;
 b=Ru/LQ6uyb+UDdErgB9vFQ4iqTYrqewO2cC7m+Ra7zYlAAgWDGc5msyAjoqbolSLFE7eViOGppVHlKGUHvoamJA8aa1aC9EG19ZV8tMv+ZMIOlNvtrafkiv0NTpDLjV5h2h6xdjW+r82YW0mUZTEhZmk/2wG5+G/liwI+0Rvo6yB9Z6q7cAiETmTGuN2KIjtpFR45xlRxcySK4fB27EH9RG7d+xONJDMB0NWJkEXOPTrrDcZ3B7PsHRq1W7SPW95TbP67YOgaOQUlj477DDMOSrfiiZdbg8Kkk+ceSWVp/H4HiL0LWxS/K/fOggibEE6JvG6MQLQ/e/AWugZ4koCWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qSUq0JYh32zXpbuOJjFm2JfJgRqI7+ySbhSmoGYkrA=;
 b=EXC8yEI9S7ht3SPE9VWiRG5eB9misSOpLS9hKbHy66Nf9iWl7g41C7YLiZkCt8gEl7iTAt19DtSxaWKRt0xk1Q0v1prmyooRa4tAB/2ehmL/q6ORqc6jM39MpUjiyaJFfiWIsUVFnV8sLHbBcfYW5JlRvDAEyvA9K3EUnE3S+U0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3923.namprd13.prod.outlook.com (2603:10b6:5:2a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 19:24:34 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 19:24:34 +0000
Date:   Thu, 29 Jun 2023 21:24:27 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1 1/1] netlink: Don't use int as bool in
 netlink_update_socket_mc()
Message-ID: <ZJ3aa4jfxoWBc6Q0@corigine.com>
References: <20230629133131.83284-1-andriy.shevchenko@linux.intel.com>
 <ZJ2fG/2AzJ5O0IFr@corigine.com>
 <ZJ3Ttq/zRRKSVyDp@smile.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJ3Ttq/zRRKSVyDp@smile.fi.intel.com>
X-ClientProxiedBy: AM0PR03CA0095.eurprd03.prod.outlook.com
 (2603:10a6:208:69::36) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3923:EE_
X-MS-Office365-Filtering-Correlation-Id: ded5250b-d2d7-423c-fe5d-08db78d67840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39jrI2EIPbV76qEOoeTk/UTjWhXBTRzcDuWZsHEkN5YookASKEHNnWDw1RHRiGPPDgekrLf+uBozF0p15clZTY+51VIjwcKV7eAzDPw697EtazzW4HdSPrn9rVcJFWhflIBLTktSzqxEVYOx6DZU3Zb2IxofPORg1h+h+P1V9jkYKwj4MAnVeqL2cKJs5m14ORQ5f7hAEfrCcferM1gjtYB6cJOw4ueH85O1s7kLqQz7L38IBt7qRrt7ZsjJrDhc8isler4ect7soD+01jbsW+y5R6PPBdYEBnLCsKZY+2PhiSNkwMF5fT9Vjj37jDp6qoy6bAu7en/9/ileat0ZP0TTC6TJBsLDiS9xpucOPG/ee6r8E7SZy0WRD/CBQJwJhSnYoSM9zV+d5dKPK05FYMeTG8KASKadfoKMsq2jK8p8GrTfmWYepksGM2p8SJskcZlW+PeqCZeGdtsGW7elK8lnVXmracsNc8jfLeI0dv9FbGIXRGmgCY/LWyXJW6IxDUmwyPnhmHSdybkJgz+8j6VhiqsdDGTognZHfR2wQBl1ekK6+T2EnbRYcvpc3OpohJLnCYPUMRFldrgcLT6bInHh365K4Kaqyp84Jm+U/Ey3sJaxnsAUCphaRB3rjvJtCfRfMmHlFUJ0F14bPhv8CyP/Zau9pxFW422IOyPxB1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39830400003)(366004)(396003)(376002)(451199021)(6512007)(5660300002)(66476007)(66556008)(4326008)(316002)(6916009)(478600001)(66946007)(36756003)(44832011)(8676002)(8936002)(26005)(54906003)(86362001)(2906002)(41300700001)(6666004)(6486002)(4744005)(6506007)(2616005)(186003)(38100700002)(83380400001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rmTKa4s5wLKPS4ZtX7p789BOfvzf9eLcwIIE9TPvmPrtqhB1VSe1rgq92kNs?=
 =?us-ascii?Q?fCPY2pdS+OghBf9NymGwkygvGbPiTMw5Mn8i0DbSp+lofSKjCwTumTjxRrIt?=
 =?us-ascii?Q?/I9hNGDYUwQ/xj5PajUqa7mEqmv4vuho7rrOiwmEqUXdI79JT39u9nDpx+A5?=
 =?us-ascii?Q?myo9REPpNXVZ/yA+U8dInx+u6hanDwXEMToJA9/6cb+c4yI4flDj8pripTWt?=
 =?us-ascii?Q?scDVMwzLynMD0N9XfqQ74HOhrTThfSC1KkyQ5LYxTNZyGLFYHZlGbX598buh?=
 =?us-ascii?Q?XpAABVGznfXLYxCKDDHwTEq8BOdaLcpN5usfWhfQTdrkZTPhFt6mj7NW/HFn?=
 =?us-ascii?Q?bPSHdPxXZ0UjnDCKPcmZ3hzVH2fzZKoHWY4lG72jv7dCYXI4w0Nd3DJ0wUnx?=
 =?us-ascii?Q?xVW5AeEcuzkmVncH+iEG+dIfIFgXKaxuN/3aEYo1O2CVSNp6NuxCz9coFGux?=
 =?us-ascii?Q?GYAoaq0X5SINSWwI3EALda75dNPH95xp6Hiokmi1w4R/OfLSKR+r8pPtKoDC?=
 =?us-ascii?Q?+qnNtGPDvSiHs5y+hsfbSR65/kR+P1MjEbIQGpCPsQp/YPH5yfzDdHrOs87/?=
 =?us-ascii?Q?3El5sZGZqEYvtXfQCiU924mMpq1RdyQIRUdPhv4PvakshtW1RgFFySQnB35g?=
 =?us-ascii?Q?F0bF5o8PgpYRwF0qOp3qhxv19tAViDlg6ahz+K8TRGBWmzOHjfriwBS+BaND?=
 =?us-ascii?Q?wgt5pqIFTvSEMRFPpDDz7h+3KSTYNf4dgbXQ8QUqws0rrxggBD8p9uPzvHkY?=
 =?us-ascii?Q?geO4lQ2Rj5L3fbzdVIDKfdMrhv5zx0EPwla9LA468XlY4RfkFMXF1WefVFwt?=
 =?us-ascii?Q?ZDobZ6o7ogsaSuQ5Mf0qOkEsBb1A7Wi5MbPG7XBOBFtbno7P8w2WIuGz3gCX?=
 =?us-ascii?Q?msUNL2TvzmeHzy019nec5P5KULIljfH/Dut+uwb25Q8VQx8s8CYRBsE9U1v1?=
 =?us-ascii?Q?syeoVnFKfWIRt9fnLbaYRLT4iaA2FztpKEcvRuUVFDVqslHUGf3oOAxvaiss?=
 =?us-ascii?Q?JCS5t9es7Y8bsBHZty+zVOmON0ojfurwKfbMp2NQguypRfDErqmBKNtzWmon?=
 =?us-ascii?Q?k1kCmTl7GIL2bbSCmCD8B6Vknf8S31YaN8Ru6xs2EVx/b8efhBFBeDBbQvXZ?=
 =?us-ascii?Q?IVrZcda0tkCoaUtrZj6PddCiYAakVFbJ+fTiBsJOrlSgqsJLeehE+Ci2bN5e?=
 =?us-ascii?Q?lWp/1GrsaA1DUp1f9atfcPPNQq9BLwu84buVMfj1U6nLjArGBhSHwPo1hm6p?=
 =?us-ascii?Q?pV0oZaqHjj8CLShcXGKXIryNEaLxqPHA56dwqXfX0lEjaAZoNkf1lIS970Z8?=
 =?us-ascii?Q?ikYcxzNdcv0YkkIKQG5tbrnLl9TS7lk7uhod0ObQUgJQUW4vniC0OMOpZuS4?=
 =?us-ascii?Q?jldPoHUpoTdHNEYvBTR26c/le6MtPe3ycl7lN4gxPdBHO1TM9pJdCwOstazQ?=
 =?us-ascii?Q?Y/Dbk6i6b2Esym2SB3rwrRJ3aQx2rHJPW3i5WANTV29EIqD/BtjnNCUHMGn4?=
 =?us-ascii?Q?HM02mMrNVIRRY7XVP6KV/c/v7oG/pF7VVs8eoIb8N9aib99S+Ij6XkNwe+Ux?=
 =?us-ascii?Q?Ji450d7TW1D5nt52Te1LnGQ+hALOM3ezxYFpvoLx34D7Zm/mYw95ZYBY4UKx?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded5250b-d2d7-423c-fe5d-08db78d67840
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:24:33.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sxjt5SaWyVleeUlri5NQ9ahIsuIq3/a+h+Ge2n5kQOLX2x7qEIyWoMLCZXhcNKfEnKS62PnO2g0bPbVo6Cue6YJ2oasTozIeVNb2DQ23ZT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3923
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:55:50PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 29, 2023 at 05:11:23PM +0200, Simon Horman wrote:
> > On Thu, Jun 29, 2023 at 04:31:31PM +0300, Andy Shevchenko wrote:
> 
> > > -	int old, new = !!is_new, subscriptions;
> > > +	int subscriptions;
> > > +	bool old;
> > >  
> > >  	old = test_bit(group - 1, nlk->groups);
> > >  	subscriptions = nlk->subscriptions - old + new;
> > 
> > Hi Andy,
> > 
> > Doing arithmetic with boolean values doesn't seem right to me.
> 
> In any case it does not change the status quo, the same still applies to
> the existing code (that's implied in the commit message). And obfuscating
> it for the sake of purity seems wrong to me. Hence this patch.

Yes, sure. That is true.

> > In any case, net-next is closed.
> > Please consider reposting once it re-opens, after 10th July.
> 
> Sure.
> 
> Thank you for the review!
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
