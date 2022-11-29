Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D9163C6BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiK2Rsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbiK2Rsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:48:33 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0701360E93;
        Tue, 29 Nov 2022 09:48:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiKOPwCOfSooVww+AbmrnglbV6LCISlTpCGse1lE8nTSxRVJIWxJwWCiWIrh7AiDIpcxDDkI+0GMPs8DBcUERMi54PXY8xIGaNF5DE0/80O/H3odmq5tOvPiP6hQr54fOBXRthZEAWdPhc6OoHI1q3y5CyjtaDn96sSPeQBUzV8TK5+T6JT2t14tqeY6b5Ek9HzYFkfvjRRgJAgEYEyyUUN29DODS5W376nNxySEyKpj33L3FOed8WK9HNIY0bsEZE71Jl5rCNQuGjRr2+/TDEKF1Sqp7kEYW7j5e76n3/pGDnWV0iNgSFtXiGuayUUWHuy63X6ik6Yillbgtu7VTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JmtI2nKLzNuQ7yDS0jbfn60HyCMDXC8c8pDb/CDbec=;
 b=lkuxsr3/5BpXvg1tvpOyAjanQFVozkyjwBfDSGyBjmMqDX6h50o1nuvqTgCbKu9Q1IDzC1o6RA1LZo5QPgpjIsgioRBK5GP4pfD9iQU01ChrBrBTLhg957tO5a11W0THBJLWImmYxeRcGpmc29QNRQ6/7T3bSR/44cKhlXSa4MSEuvVWy1BRgLE7RPJsMieudVrnfM4RyKsyw4HXccxmoWvvDY9kycELKDRlH2q9lHgdc+iVEqbT2FdW+mWF+HJks/zRM5NzIQGGYUQ2Bml+Ik+3FpUjAMdJL0FICab96/g/d91fD+yNJUvTaEWXBLnSOH39VRSkgBJz+5jRcOXOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JmtI2nKLzNuQ7yDS0jbfn60HyCMDXC8c8pDb/CDbec=;
 b=LiauTfGyvi7VAnC9oAbUGSaSdfEum9cVrbLNqNNn/wYuPOqIKQClC4RahXKzrUbRfZyfOxbIFD5ZzRXFvPXl6Ap8CNYd72f6TVRDbMG8XZmwA9E680/8H0IVPMgu67Y/dG4IXaSxFVwKoXG7sFn3SwZdbqnvDVe+ZGxAYZwimjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vpitech.com;
Received: from SA1P222MB0296.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:1ff::7)
 by SA1P222MB0214.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:1f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 17:48:29 +0000
Received: from SA1P222MB0296.NAMP222.PROD.OUTLOOK.COM
 ([fe80::1ac3:14ac:b83:b2fa]) by SA1P222MB0296.NAMP222.PROD.OUTLOOK.COM
 ([fe80::1ac3:14ac:b83:b2fa%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 17:48:29 +0000
From:   Alex Henrie <alexh@vpitech.com>
To:     Johan Hovold <johan@kernel.org>, Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexhenrie24@gmail.com
Subject: Re: [PATCH] USB: serial: cp210x: add support for B0 hangup
Date:   Tue, 29 Nov 2022 10:48:26 -0700
Message-ID: <4760090.GXAFRqVoOG@demeter>
In-Reply-To: <20221129141539.15176-1-johan@kernel.org>
References: <20221129141539.15176-1-johan@kernel.org>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: BYAPR01CA0060.prod.exchangelabs.com (2603:10b6:a03:94::37)
 To SA1P222MB0296.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:1ff::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1P222MB0296:EE_|SA1P222MB0214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5800bf-3706-4e24-73d4-08dad231ec78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g81SJ71FCri4qCf2P9rfP7casjUTpMa/lWr2cUOvcuO+d0C0bhRIVLxki4R7nNWlirUIPaqSur5NvyspyhkWAIj19+6BDKvakVIoprvA3glhc+gWxRy9KLbXOnH/habU0Gz7olvUpseSxCthkNZt5nDkKf16orroOXdzWIvxQOiWfUVUBHFdmUdIDKGpxRNjPaUonQap/MafzAuS7vAK0dv21ECNktiJeCLf8JzcGTgRwsaLLnxjJLxNFhU3B8AALnaLSIhXq2NOdsPOWf/Ad6cmuaLEO4LfE+CxfC8HPzxVv82Q2D+zarLJac0XZI8PLc2mAk2dNTMa06T8qNJuaudRWGqwunT6lKE3XkwccFqHvtwNc2KP5R7HoBJDTfdMi2Sfh1CE+wSLgG38FovIdmBCH7JYo8+mpnIhUsZ9C11hL4VtVkwBVA3CJda2yq4U3ZV7FaYqONt/osqZvTnEtlLpKF8T7l4NECjXMKqFX0fYyL8Vo0qtzJqqj91yL++WOrepGEcfM8lSqHL+dQhCPuwWaHaSkLMHDrXP71wDA7sJVVtQu+77XLunhDA5+InVuj3ugEKBXNPMus9R4lfLrzKqafWCgPYY1uwZwtMufJQtcAlWtBrOliTQYFTSypxHE6siWC9u2lB++10fL92TSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1P222MB0296.NAMP222.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39840400004)(376002)(396003)(136003)(346002)(366004)(451199015)(2906002)(4270600006)(6666004)(6506007)(38100700002)(478600001)(6512007)(6486002)(8676002)(41300700001)(66946007)(66476007)(66556008)(52116002)(19618925003)(9686003)(33716001)(8936002)(5660300002)(558084003)(186003)(4326008)(86362001)(110136005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jl3klHKSsixQtTbrS3FgamgAecCrNcKetqFfKAWyHSp51Z/b7ac/aeq0LiJB?=
 =?us-ascii?Q?dEez5tSqcG9H06WHIlWw0/Mp8RS0JtKpGGK99WjEM5VIIenQ1JLAkUvObI91?=
 =?us-ascii?Q?vJnBNsU5Mzu/wn5cEVcU5lGmDz0L0czUTfO6XXN4+hkj0T8Jk6HjOHLIxmLN?=
 =?us-ascii?Q?lFSMoQNozwMhEgnxrXpNy5vH9h2nHvtD+JV9e5VJ1oBDHoQVXONEdvx7S3Sp?=
 =?us-ascii?Q?02F+gziacUVt1EKBFHynpRU9HQGJwW6YymJRWa4E3gHRMIc52rTlV6MPHg3e?=
 =?us-ascii?Q?DqsBrJFUW81beLWRJHbaRJt990hycpaTp92I6HAwfvWuuRuLY8zW8tRKnbRH?=
 =?us-ascii?Q?6e3WDSHMiRa+bViV87z8i4t4C+7cg1MpnWtrxYeKlzNHNh421Ksx3bfz9wby?=
 =?us-ascii?Q?pvBET+Ca1jbwXxs0dWuORhcxNRObEjvR3nmrYj7zVbwItY1FGmCe8Mxt6gNA?=
 =?us-ascii?Q?ABeCvfFf40If0sjz5uWHnY4RpVrfm6U53oBSMSHtE2kgKQibrkdbtMp4SRog?=
 =?us-ascii?Q?dGVjKbP0Lch2Hhf7bh/lzpRyt9Q0Vcji62fBTYknwIk9onhEGFd9O2xSwzDz?=
 =?us-ascii?Q?OCgJQZ+hLkquUyDh2nDBWwzzp8qudjU/OAGN2SLqBva1KlWoR2OKUWnpTEt4?=
 =?us-ascii?Q?IJ5HJJ70xE3F0wnAmWAnfAouMeDPLLeXmv6xRkGl/ciOAAxgq5iaomZAtINo?=
 =?us-ascii?Q?HDuqJlwF5Fi1UMJcPUcDe8TjBXwK3WswsctO0XubbZu4Avblwx09SCL3nHok?=
 =?us-ascii?Q?lRpsonK27AtPobeaXufrrvf4VkVATN3/V1TfawdtMaDCQ9iolAeooH9uMuXW?=
 =?us-ascii?Q?lSMkLVGqN5eWQM+yv/ab/DuWzrJLtmGRhtL8QsvG1Ke186SF0RTTWmDY3+MV?=
 =?us-ascii?Q?rr46AdzSO5FZXFQiZ6yT4/7rYgPbNYpqIaEWK+zhdGSQmJtnzZnT8hqTvFsA?=
 =?us-ascii?Q?er3C5yZTzpdengXtY9omDM73d8WdvGwZq2MTK0Zy4K21myc6ZnndpRw2UHHj?=
 =?us-ascii?Q?ta9oj+s4nNHOC1ATVBJskl5Ef3daejtxvxztvLDAMlVKiE+CpS6LoxB51htq?=
 =?us-ascii?Q?mJ2WMoH6dFdL5zAxzLu3Dh8WDnEMuU45Qwut8HGYxRpgSDeuNgZV/PqEL4pS?=
 =?us-ascii?Q?spVj/SMxQH5FKNcAM58sY3rV9utmy0FLlpMdYRut826WpmbfUcuP63+E7YbA?=
 =?us-ascii?Q?zGS+o+MyGJEUCvBiGQQXv/iutPpYD/m2Bei5LB+2JmtgRTb9cwE/Di0gSreS?=
 =?us-ascii?Q?OyZBPM0SUGy6AbFJ067JuJVTGaJF6FxOsIGlTLeD3h6e8pDsuCxJqIUsibd2?=
 =?us-ascii?Q?4TKBP2TYogLptKbVv9UiIlNp3zrp6P56lA5MvHHNHjPKZ63rQjZMbNGet3c6?=
 =?us-ascii?Q?Z4Rn/oXoK18RYfd2srQt9mjy63otVLQOPsDEazjDwxY00t28UP9h75lfK+mF?=
 =?us-ascii?Q?b+l8NfomM9xSUn+Lgj0vXJhXari76OP5NbNbKHrdUZ7B0ZH0oRgMS/Wt2Wmb?=
 =?us-ascii?Q?4vA2PhUg3D7xhmtdEr8u+Z8r1USZlAaUV823DY5v81oSFbJvI7BVEnVRvR2d?=
 =?us-ascii?Q?HB3effHHA44UciV0oAX/CizAT1McmPKiCI/KyseKIBtqUuijiD4yjxAZ/gKA?=
 =?us-ascii?Q?S8drUdTnnBQfSUttGX1LqPE=3D?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5800bf-3706-4e24-73d4-08dad231ec78
X-MS-Exchange-CrossTenant-AuthSource: SA1P222MB0296.NAMP222.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 17:48:29.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/Dh0J/T1eC6EK+gh8/U4GFxkItzWFhxiXop573MvHlJkC53SR/MUYO58a0GMyJ+p/Kko25L9OPO76/hzdZdvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1P222MB0214
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Henrie <alexh@vpitech.com>


