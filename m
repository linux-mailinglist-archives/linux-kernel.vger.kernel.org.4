Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1D973B1BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjFWHdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjFWHdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:33:16 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2129.outbound.protection.outlook.com [40.107.102.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003CA2130;
        Fri, 23 Jun 2023 00:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHoNOSEjUulSDMXWwnrgbUEEeju7b1d+3RSI9ly62lAvOT5KcpFS1fJRdHjpXIfTNgFEANsUbBmcAPKQ6zmPUJb1LQjt4153Ni+9IRtmc24cbhCIh5Um7qgyRkDXxkproy4Af63ssukeXz4VVzhhUOleUAjc9HM3unPTWL1LtVoe3lRwB0LTe4tr1S6nk29VKAsZQuYu41DHxivSE516I0GWX15quZZDj+pY2G7GrBHn14dh8f3G6RQOyVjIHMaW9aWUXcKvFKv8+q8vJJ96hI9OdfJtNYEMHi8/tvwZDPVqBzsmpisArfMD8zeSAWPwW2ufJuwfHRWJKyHGRGXPrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5Klt/CtSYoyclyi0Gbem5htGB7S8rg3qX/9/2SdbFo=;
 b=j4UT4WdObudjQ6iv3LDPT1OlKD1YN420ZlKFzZxZ1J2Acc5W7+Of+OCOvnI+nlpcRDyh74Qj+EWjXhcv9ii/Licajo3IfRDCgbJTNfFSa5f58g/8cOwgumuVQoohq7JZLy0nbT6FM2navchfeJ06CE8lp/K+wRT2fvyNFlxxzyfMhKbf4bxliYanWQbmITDOqYwi1WKiO0E5TCYISnCiBR699VbXdObL0X4wtCaSLXpihxtxJTPBophCFYX/bEsfQ0sIuyig9y7WQqxHtjhnktAhyNJ2v0GVCYT7jNw7mzgYFTwBDSWwqrfxJnh0uIJk5ftA+3w8Rp3d9vTbyhh46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5Klt/CtSYoyclyi0Gbem5htGB7S8rg3qX/9/2SdbFo=;
 b=iiAVqYrPhzLd+VPk1maad4xBIuEJ58kw72gs/TP9DsKqvLHgnfwMaYauej8vNQuBuQFSKGago3UV7xqBqwGNGmcwCWTsIqFfQwu/xDd/9IO0d8WbvEkyRG5jxZof+JB8+Yv+8YU7Xb5cwOpJawR5z11XJcCGJS2ki6ZcXPnxYWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4800.namprd13.prod.outlook.com (2603:10b6:806:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 07:33:08 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Fri, 23 Jun 2023
 07:33:08 +0000
Date:   Fri, 23 Jun 2023 09:33:00 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] revert "s390/net: lcs: use IS_ENABLED() for kconfig
 detection"
Message-ID: <ZJVKrClDvnRnapT5@corigine.com>
References: <20230622155409.27311-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622155409.27311-1-rdunlap@infradead.org>
X-ClientProxiedBy: AM0PR04CA0064.eurprd04.prod.outlook.com
 (2603:10a6:208:1::41) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: 871930ef-8ce6-4636-9f02-08db73bc1711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfMOy2gFyWrvEtprnv7mb2m74ey2q70Pk/tdPlWGQugD/jJc72G+Nuit9GDMrYR5AxjhIQU2ldbzIdlFYut/AdPVZNt/MhXUIJz2N9jkkiIm7pchqp0mfDh8TPo2d/oiIasEtT6t1zMLl9oXax+cGdeFR9rFPthfDgay8pKYSya5OJV2vtoLQiasTlyfh4zLc4UE+s6/R0iZznQ0JV4QLNs4+fSVh0kg9FmyBn0Vl/yqUoKmddWwRT9heGNW1z+BGjshOppdEz78wxw98JFwBNI4cXYV8rA0CT9Pv1dDY6g1v6EKFy9BrzhZXv67AZKAnUiYaHsj9yBng0AuXfDCHK/U0L3oKbsFI1soaT7vGSX9wyxanwxyYEx8pkMS1FTREW63q6H+IpsM/11YfJnR4MFUYADXumlOngPWGKFX25LK9Q+N1VdImFp3XK1W7kUgHX4eQ8xRYfZe/S3j3uSngZriXaxg2bWerBW56CQoBRHV+WtDHGZQt2uQcqQpVYIjS/kzfj1MNftVuK/m+U1KskSWwqTw5mu/v1uOt94YLOsS0mu8o1tgpdjouNW1mg/QlAbJIjRroDt6LVjrQ9jjP0L0laQaMMDPmZUJOtbPtoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(39840400004)(136003)(451199021)(2906002)(6486002)(6666004)(2616005)(83380400001)(38100700002)(6512007)(6506007)(186003)(41300700001)(54906003)(86362001)(478600001)(36756003)(316002)(66946007)(4326008)(66476007)(8936002)(8676002)(6916009)(66556008)(5660300002)(84970400001)(44832011)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VbthgSMphuvLVAglV0zh8K/YXRbL6eGJejKkb2m1/YGH/qGDi50FkqrMznFG?=
 =?us-ascii?Q?+RLhDj2CXtYthTyCFoovr3o8b9Mmj/4Noqty3o+vTnxXQUIGw/3DUPC6FkrV?=
 =?us-ascii?Q?Afi4jMK4A8c1vC+47cUdAOmbAVHfcVEBOKLomBHt7yJSfxvNIFCJyiGKgQMG?=
 =?us-ascii?Q?VCwv+eSTJXj1pOFJrDYpB8fO/uqsOxnyxeiBi/YWGiGzArkCNOB/qbmZQLgV?=
 =?us-ascii?Q?vcMY8nYKH/4TUuxLdNGr5KWdkeUMl1bGllU+oSz3FMwYQMUv++4J9TIIldYw?=
 =?us-ascii?Q?KpxSaPFeDkr5xK8eUmQJtNA0E0F4xmAva9NRi4ZsCNUiWxKgkkSZfFpCOnP7?=
 =?us-ascii?Q?w093HH7DBqm+j7ZtPsUaSK/uHxu467OMmEiEno4y6pjCC4oUbdpE4GVsiaG8?=
 =?us-ascii?Q?p/qNp9ElxdOA+7VEBY4ErLhuao6e6PadScGqDvQGGjv4pKRARwZg+B3Km640?=
 =?us-ascii?Q?36e4QfvyrKFbfDLznDSzffXWB7ApYrXMTPaKWQPnbKpmmHQXC0bXpJgddERU?=
 =?us-ascii?Q?ZeJAVxCTH98tCQbQVuKyijCY2SehhTJr4sbpWGjHnfsHY9DaMaWlJzdv0Odx?=
 =?us-ascii?Q?89k/H5SpNvqxFAAuLbZQVBj39cmkJlxuIl57UgtZns48k3+rXrXYr7mq21ff?=
 =?us-ascii?Q?LzILvn7NEz6lMX34wzp0QsoxLnACdvpL3HnIvveXAY9r0i/ZnYkMSGC19WTE?=
 =?us-ascii?Q?OukWJrHzUEnUSlM4xtB1/pP55Ij9GjxbfEo6CbRolUtgm8JtKC6qKG/TxJh1?=
 =?us-ascii?Q?Z+eAbD4nXJnk0/DcbF+9WSwCpM93kfpg92M6QDqvHR2BYuXAkU0s7qfSAfM7?=
 =?us-ascii?Q?OhBNLb0I5vCOyBkhhI3ohU3w7cLwvR55Schau/0XB+lUt7gkeXllhZDc42r5?=
 =?us-ascii?Q?U17RQ4qPMJlMMhorG8W8JVH4/NnT7SWuJ2Xbov/fgeYjQoezEtB0I99z9i2U?=
 =?us-ascii?Q?GRFDhZSPMTrBwweEv59ubqLoV5zfZgiRw0g1hF01+GeqGb47AeIA1UPn4A1c?=
 =?us-ascii?Q?Q55/5wLLBSkkxuxsoz7Bs6dnU3pZn14FZpdrXsvifhOroAZu2oQLyZZminEB?=
 =?us-ascii?Q?UEkootddTLg9UraQQhkm8GlQwAmNNMat623lgtLrt0bj5h8w3sX1toFuPb36?=
 =?us-ascii?Q?to+sejMdlyrWlenYFqyyKr+hLBspAGMBYpXrPlZ68Hj7Lvy80eVIeQ/7hQ/6?=
 =?us-ascii?Q?ZTEX0Us71su53E8ZTqjWh759WqS7XhbhJ2YJzgv6kV8RQeNwct3JGKzMIc3q?=
 =?us-ascii?Q?qwwY0hHJYfx8rvap3nZTm0N7Jr1MgI88oKGy8kVA94GknH4wMoPY3rybZ78c?=
 =?us-ascii?Q?uwWBXS7DoBulcfRzhebWQcQ6iINUb1yQ9wX4usL+7WVgxxoxMjzs9SOSbHYX?=
 =?us-ascii?Q?RSTs72iSiV1BRo7/gOC7KWbVpAwyVjCc0ykh9bpgDssW07Tulcafi0ormte6?=
 =?us-ascii?Q?Gb/wCp5Rhv24Oc0jtBzRPtAWSDn9wX7jACbzetHxV93fG+YO+x8h+oUHEhRV?=
 =?us-ascii?Q?ajhkH/eaT+vel262AE10ouNzEoLfk1ZPEeW+aqVfELwUW5+FAqu3DCtg2qwd?=
 =?us-ascii?Q?SVdNaU6qkKy8VSZTFXd1uNZdq2jWt5sfezQxbPIeElduXOroV+OZiiiNz9lF?=
 =?us-ascii?Q?eEMWePBkabzq06XWAvnrRV4SZbq4VpMFE5Rpk+iUY6HL6gNV2ZqMrkXE/l0o?=
 =?us-ascii?Q?gji5oQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871930ef-8ce6-4636-9f02-08db73bc1711
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:33:08.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/I2dIZogsdmNWPA82N99BmgfZFv+S9BWj13X77aFpPUFVZWHcBCiPlnMzxRqafUSe6VIomovmz5sWxbvTgtCFrZP8CukyqkJsL8TzBXFOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4800
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 08:54:09AM -0700, Randy Dunlap wrote:
> The referenced patch is causing build errors when ETHERNET=y and
> FDDI=m. While we work out the preferred patch(es), revert this patch
> to make the pain go away.
> 
> Fixes: 128272336120 ("s390/net: lcs: use IS_ENABLED() for kconfig detection")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: lore.kernel.org/r/202306202129.pl0AqK8G-lkp@intel.com
> Cc: Alexandra Winter <wintera@linux.ibm.com>
> Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

