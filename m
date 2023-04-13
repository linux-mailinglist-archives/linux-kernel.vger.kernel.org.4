Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB53F6E0B57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjDMKXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDMKW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:22:59 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7FAE9;
        Thu, 13 Apr 2023 03:22:56 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D7qO4E009154;
        Thu, 13 Apr 2023 03:22:32 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3px3fwax5k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 03:22:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2weGcl2vWX93S54bAyDDvB/8BK2DalWpTguN3KQOIsCA8LdC/IjVU5RGgzLVtEvfq9Qn9fAEIeQ6kBP8p0RFRMVs2uhdLAnBYijcviKCtP6EGRtvW+I9ylSIVAs0UULFQaj9+NCiR+7O/unZZ788PSBkaWlu2PpEhI6vpHYhnL4BXwc8L//5YlCg11DNZkBD4Mail8+LODcB/ARpYEWFWSidXHVTXMOoxd9v6vi9B6blEq7fdWMHdYTQ2qk+zLk1btLHq1AN1rg332fgJXZxcKJHHTqpIYrdUI9D7n0qOlQ4B3u1UKOurYSzbMvQlxVUfY2xglsHObNylWj4p15wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3arxttnbQrtnHTiBmQWa6VAIKZcYu7K5z8WdkmGanO0=;
 b=Qyujnd9u3N2+S8F3lOyq4LDF9rQD2gJ2Q9duYNBFckWTwzuPE3fSAvgRGDAgzyXK/2SKOwYeH/zYyhlFLX+0p53LJXAeP4sbpd7pCuEUCJyDTrmjHuSitL6IX848y6I4oY9B9LephTvU0b5xuYEhJ7P2HMdGwGE/es4ZnB7yrqoiElpGsWzqU5Dbw46KQtvLFPU5xa8hecvcSpPeMknMc008+0FlMZtmpxx4M8GLwl9YcLRqvNCtfwYHbwSAKz7PNHkIuRPXDQlcxA6e1jTRqyH10OFnBU/d+pSIlYN4akVY4reoFWxGwaZFphMu93KLph3pzSukmfQehaBYFT0Jsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3arxttnbQrtnHTiBmQWa6VAIKZcYu7K5z8WdkmGanO0=;
 b=G3TgRq3fgoPUrL2HKta6turRFs+ux3jAUFXQTkQJ9C3E/t46+hjf+zB5Oo1UDzUeH0GSCgmk13GJJ7B48I+RsGaOJyNrHV8fhRN3rmhO3VgA2J2JdVUgOFdHIXbm1ijnnPOV7tgwGgLKQlzpi6iqwYekWbFaQZKUbZCs0x5jGi0=
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com (2603:10b6:4:62::23)
 by BYAPR18MB2966.namprd18.prod.outlook.com (2603:10b6:a03:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Thu, 13 Apr
 2023 10:22:29 +0000
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::539a:cb03:47cd:9551]) by DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::539a:cb03:47cd:9551%5]) with mapi id 15.20.6254.033; Thu, 13 Apr 2023
 10:22:29 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 2/2] Watchdog: octeontx2: Add Pseudo-NMI GTI
 watchdog driver
Thread-Topic: [EXT] Re: [PATCH 2/2] Watchdog: octeontx2: Add Pseudo-NMI GTI
 watchdog driver
Thread-Index: AQHZXmDnieHT6oIyl0uEPZQVd86ruq8KfB8AgB6qO8A=
Date:   Thu, 13 Apr 2023 10:22:29 +0000
Message-ID: <DM5PR1801MB1883A33DF87B30008041660CE3989@DM5PR1801MB1883.namprd18.prod.outlook.com>
References: <20230324145652.19221-1-bbhushan2@marvell.com>
 <20230324145652.19221-2-bbhushan2@marvell.com>
 <b5c3fe52-63fa-4fa2-b500-6233297c01c4@roeck-us.net>
In-Reply-To: <b5c3fe52-63fa-4fa2-b500-6233297c01c4@roeck-us.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYmJodXNoYW4y?=
 =?us-ascii?Q?XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0?=
 =?us-ascii?Q?YmEyOWUzNWJcbXNnc1xtc2ctMTYyNTY0NzMtZDllNS0xMWVkLWFlNzktMDRi?=
 =?us-ascii?Q?OWUzMzM4ZjZlXGFtZS10ZXN0XDE2MjU2NDc1LWQ5ZTUtMTFlZC1hZTc5LTA0?=
 =?us-ascii?Q?YjllMzMzOGY2ZWJvZHkudHh0IiBzej0iMTQ5NDQiIHQ9IjEzMzI1ODU0OTQ3?=
 =?us-ascii?Q?MDkxNjE1MCIgaD0ic3VTSEdwSWF5QUtpN3ptZkJwMmZKbC9CNWlvPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBSFlJ?=
 =?us-ascii?Q?QUFBMmJuL1k4VzNaQVdtZEhLay9DRWZGYVowY3FUOElSOFVOQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUhBQUFBQUdDQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQVFBQkFBQUExRkgzYUFBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdR?=
 =?us-ascii?Q?QVpBQnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhB?=
 =?us-ascii?Q?Y0FCbEFISUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFi?=
 =?us-ascii?Q?Z0IxQUcwQVlnQmxBSElBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpB?=
 =?us-ascii?Q?SFVBY3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhBWkFCaEFITUFhQUJmQUhZQU1B?=
 =?us-ascii?Q?QXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFCM0FHOEFj?=
 =?us-ascii?Q?Z0JrQUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZB?=
 =?us-ascii?Q?RzBBWHdCekFITUFiZ0JmQUc0QWJ3QmtBR1VBYkFCcEFHMEFhUUIwQUdVQWNn?=
 =?us-ascii?Q?QmZBSFlBTUFBeUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFJQUFBQUFBSjRBQUFCakFIVUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFG?=
 =?us-ascii?Q?OEFjd0J3QUdFQVl3QmxBRjhBZGdBd0FESUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?us-ascii?Q?QUFBR1FBYkFCd0FGOEFjd0JyQUhrQWNBQmxBRjhBWXdCb0FHRUFkQUJmQUcw?=
 =?us-ascii?Q?QVpRQnpBSE1BWVFCbkFHVUFYd0IyQURBQU1nQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpBQnNBSEFBWHdC?=
 =?us-ascii?Q?ekFHd0FZUUJqQUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NB?=
 =?us-ascii?Q?WlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJrQUd3QWNB?=
 =?us-ascii?Q?QmZBSFFBWlFCaEFHMEFjd0JmQUc4QWJnQmxBR1FBY2dCcEFIWUFaUUJmQUdZ?=
 =?us-ascii?Q?QWFRQnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHVUFiUUJoQUdrQWJBQmZBR0VBWkFC?=
 =?us-ascii?Q?a0FISUFaUUJ6QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFDZ0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJq?=
 =?us-ascii?Q?QUhRQVh3QmpBRzhBWkFCbEFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VB?=
 =?us-ascii?Q?Y2dCMkFHVUFiQUJzQUY4QWRBQmxBSElBYlFCcEFHNEFkUUJ6QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1801MB1883:EE_|BYAPR18MB2966:EE_
x-ms-office365-filtering-correlation-id: d058b33a-a045-46db-1ad7-08db3c08fc73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a7ZUTCi4Su/2CyMEHTUnEa8wTHWpYSogf97pBMGWSW8Y56wozoImC2wgx9qDGgSM3lIEWnwt6uxaa5whH12o20rSCwRJouZZBol9HzvZj1Kmls7eqkJfOHAEWbXG+G8Cg7gBYGthCbPPo8tXhNN0e7Nt+UrYWnly62yCc08NQevk4rm54fO2nnxagw5JVG6LmTCcIrJ5DXLQIW+uJ52ZGXPcOmQB/98ToTyGy3Jgy0gH3mWzzUuCBTZhf3d1sUdhmqOizrj9Pg+zV374zNL+dARthwuKEhyHAakQAGno1iIhxHvlV4QgQjfpeCRMtkeewVvB1IEN4RmLT83mlHJi0OpRqQ+gal8LJc9ak6lfFRptw9uPZRqKgT0MxV39Eo/WaDuEjjFKipqlpWoz+eba5VJHjqF9pBbqgH72rwc9b/a4U9jqZQ3BrZ2c7DnkoBJWCXEvVE10T0dDVKzNVFbXvb51JGDYEpmSF4RHCwQ7g6cVXHcaPuKtLVB9yy7VwEoo4OeFMbK/xzytBR41fllsEJM16zvBUyBCr7nkBpnAa1GumUQV3LA7NyyfmpBAFlaTwC2lHZ4vLpo/oLI1Fv/q/Q7ba3LOi4t+MlGEv6HdVYLnst6Q8INt+sjaRGFOZfdvOIto2EecGpw22JvDHfJfDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB1883.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(55016003)(8676002)(64756008)(83380400001)(71200400001)(6506007)(55236004)(316002)(186003)(26005)(54906003)(478600001)(9686003)(53546011)(7696005)(5660300002)(52536014)(30864003)(2906002)(4326008)(33656002)(38100700002)(76116006)(8936002)(122000001)(6916009)(66556008)(66476007)(66446008)(86362001)(66946007)(38070700005)(41300700001)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1ODkSCfLth22jHEAit9SlDB6qIvfOhTSW85VQf8PJy29l5Yq4/GqimdRPmuu?=
 =?us-ascii?Q?6kXWQx134GwMoO8s5p8DyHbKUQabYulDXMjAllfbiCJQ4fDrq1s26Yy3Mdo0?=
 =?us-ascii?Q?hA2rvZT+/lYkwUtDcHHCbv1sIYlAkkYNYPto9tAGdH7/ub1hoTEzV751nIHP?=
 =?us-ascii?Q?NDbJbaZiiAzFs8z70w7ms6I7rE7YDDSHHHKTfWz6k3ZZbfWokH1gcF0liVAf?=
 =?us-ascii?Q?qhmZGtElIeq9qHlnU4cSumhrhwU1OVxTmxjYax8oV/2m2otuF+aQqIcsKvlo?=
 =?us-ascii?Q?LOrnHOEqFhD1BkubrEgR0BTOQD090NgEFZVHuxcoXrJs79qBhYTphCQLjZ6r?=
 =?us-ascii?Q?Rk6EXRc3SchV5PGdM3m0S7FXt9I6PS9mlG78HAPhyWyrEGdvslePS6TNolip?=
 =?us-ascii?Q?vw/nfo4q22FR30xPqHAy3fZlKTcjSxg4yhUGlaaU1aV+g3ktmxxY52csx88L?=
 =?us-ascii?Q?sz3bkzQvzbhGhi6HItiDCQ+YPPOaxBpyYs/cF3ZChCgeWyidf+fOxyUkK7iZ?=
 =?us-ascii?Q?jDO78AwGoPQnc+iLYc5mp5NsL6fFMHr0eb7QThuEipb1nq7cIRhng/SA0aLZ?=
 =?us-ascii?Q?cx/FnqPMSNT0Q7qfDndNLhpecaBn2CcPcJYBrickq9RR8EddLaCud6rDGHRP?=
 =?us-ascii?Q?5FKEzqljMiNVTM/rrk5EuHeCXZBymNw4Neecpr9FyDutmlNm5igM5DfN4HQG?=
 =?us-ascii?Q?Cxo5rzexJRoDTSS6ydAmsJKOa2aGhTfsWvSFwJD8FFhnWX55lDd92zR/v7/U?=
 =?us-ascii?Q?g7zu9G8REoWvFXSc7sZbRuyYdf5slohiN3+2iU2zinF4GyJZZ7x3fVl7KhkX?=
 =?us-ascii?Q?AE8A4KXxLVl5pBlgP31apHSpipejQNRhdbuD+99bWTNVWVJgub6KOFeocj3q?=
 =?us-ascii?Q?MXeeZ0t6OLAVs3kjlNR5IF0PM7vWrxfRFRramfWZnYQpkC1O+Tb/GV4t0PIS?=
 =?us-ascii?Q?AFy6pGjxSArycMMev8lSc4onfJ5FPCh7aYT+p8lPRuBVun6BMKpiLyTctKDv?=
 =?us-ascii?Q?DLrqnyvCistYOWaKMKZdvyjoqSWOg4v0z2exUQkgpOYbr8Yc+YkK9RTkG8S7?=
 =?us-ascii?Q?PQMTNoSnsW4LuQMNJH+e979GVm2mb3j4gT2giTvNbfJU7pfgH46HuIbOQ3ws?=
 =?us-ascii?Q?iEGXCyK9yobNdUWyNc2/ZlUZ0b4ii8r/oUaAL1FUpIZZ3ZUxWW22Cv8EdI38?=
 =?us-ascii?Q?GOuYuReZVtL6CT9jmkonKsIDMh9JmZCZKCsB9NWVNdIVm/YF5y1kQIyYYQeE?=
 =?us-ascii?Q?GvBUkNmqKl6rycfx0HLLoXjdYtD5wLMXIwIxzSPK/AfTD6qAiYvqEh0wy6bA?=
 =?us-ascii?Q?zF+MgSUMIOal+RYsXtyOOCouvv0msURcKMHao6l0RJ7yKmRn5nnX3NlHVyLM?=
 =?us-ascii?Q?/oXtUv1rzpsF65IS+5b6VT5z7k+nbGvVWj7scoNTHCa9orUQHZYdhOTofNhw?=
 =?us-ascii?Q?l4gA10T9ZGjQcAK+B7mZimTLrOAD7NqwzYdiRsrxSscQV7LbqV6stOqEqpAf?=
 =?us-ascii?Q?pm2e8kIvPERlkaDskbLl72VeqXgoCUCuCKfcFEgF7M02OpZfOI2ht76CKaHn?=
 =?us-ascii?Q?JARfXeTh+y8Ajp30mFIoAR1vmJg22P2tHOmA7czh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB1883.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d058b33a-a045-46db-1ad7-08db3c08fc73
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 10:22:29.5862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6R1NP5EIO9wO6qRS9gIvkiTu4FH6QeIDnk7Rr6pQFyTgG03XGNij44MpgGVkC/bFO5K8joI/97Z0yg+TRtIxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2966
X-Proofpoint-ORIG-GUID: 9EMNbTwo0-JG9VSusvnrwZj-ZWRg0dFt
X-Proofpoint-GUID: 9EMNbTwo0-JG9VSusvnrwZj-ZWRg0dFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_06,2023-04-13_01,2023-02-09_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please see inline

> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Saturday, March 25, 2023 3:33 AM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: wim@linux-watchdog.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-watchdog@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH 2/2] Watchdog: octeontx2: Add Pseudo-NMI GTI
> watchdog driver
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Fri, Mar 24, 2023 at 08:26:52PM +0530, Bharat Bhushan wrote:
> > GTI hardware supports per-core watchdog timer which are programmed in
> > "interrupt + del3t + reset mode" and del3t traps are not enabled.
> > This driver uses ARM64 pseudo-nmi interrupt support.
> > GTI watchdog exception flow is:
> >  - 1st timer expiration generates pseudo-nmi interrupt.
> >    NMI exception handler dumps register/context state on all cpu's.
> >  - 2nd timer expiration is ignored
> >
> >  - On 3rd timer expiration will trigger a system-wide core reset.
> >
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> >  drivers/watchdog/Kconfig                  |   9 +
> >  drivers/watchdog/Makefile                 |   1 +
> >  drivers/watchdog/octeontx2_gti_watchdog.c | 352
> > ++++++++++++++++++++++
> >  3 files changed, 362 insertions(+)
> >  create mode 100644 drivers/watchdog/octeontx2_gti_watchdog.c
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
> > f0872970daf9..9607d36645f6 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -2212,4 +2212,13 @@ config KEEMBAY_WATCHDOG
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called keembay_wdt.
> >
> > +config OCTEON_GTI_WATCHDOG
> > +	tristate "OCTEONTX2 GTI Watchdog driver"
> > +	depends on ARM64
> > +	help
> > +	 OCTEONTX2 GTI hardware supports per-core watchdog timer which
> > +	 are programmed in "interrupt + del3t + reset mode" and del3t
> > +	 traps are not enabled.
> > +	 This driver uses ARM64 pseudo-nmi interrupt support.
> > +
> >  endif # WATCHDOG
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index 9cbf6580f16c..11af3db62fec 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -230,3 +230,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) +=3D
> menz69_wdt.o
> >  obj-$(CONFIG_RAVE_SP_WATCHDOG) +=3D rave-sp-wdt.o
> >  obj-$(CONFIG_STPMIC1_WATCHDOG) +=3D stpmic1_wdt.o
> >  obj-$(CONFIG_SL28CPLD_WATCHDOG) +=3D sl28cpld_wdt.o
> > +obj-$(CONFIG_OCTEON_GTI_WATCHDOG) +=3D octeontx2_gti_watchdog.o
> > diff --git a/drivers/watchdog/octeontx2_gti_watchdog.c
> > b/drivers/watchdog/octeontx2_gti_watchdog.c
> > new file mode 100644
> > index 000000000000..766b7d41defe
> > --- /dev/null
> > +++ b/drivers/watchdog/octeontx2_gti_watchdog.c
> > @@ -0,0 +1,352 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Marvell GTI Watchdog driver
> > + *
> > + * Copyright (C) 2023 Marvell International Ltd.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/cpu.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/watchdog.h>
> > +#include <linux/sched/debug.h>
> > +
> > +#include <asm/arch_timer.h>
> > +
> > +/* GTI CWD Watchdog Registers */
> > +#define GTI_CWD_WDOG(cpu)		(0x8 * cpu)
> > +#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	(0x3)
> > +#define GTI_CWD_WDOG_MODE_MASK		(0x3)
> > +#define GTI_CWD_WDOG_LEN_SHIFT		(4)
> > +#define GTI_CWD_WDOG_CNT_SHIFT		(20)
> > +
> > +/* GTI Per-core Watchdog Interrupt Register */
> > +#define GTI_CWD_INT			0x200
> > +
> > +/* GTI Per-core Watchdog Interrupt Enable Clear Register */
> > +#define GTI_CWD_INT_ENA_CLR		0x210
> > +
> > +/* GTI Per-core Watchdog Interrupt Enable Set Register */
> > +#define GTI_CWD_INT_ENA_SET		0x218
> > +
> > +/* GTI Per-core Watchdog Poke Registers */
> > +#define GTI_CWD_POKE(cpu)		(0x10000 + 0x8 * cpu)
> > +
> > +struct octeontx2_gti_wdt_percpu_priv {
> > +	struct watchdog_device wdev;
> > +	int irq;
> > +};
> > +
> > +struct octeontx2_gti_wdt_priv {
> > +	void __iomem *base;
> > +	u64 clock_freq;
> > +	int is_nmi;
> > +	struct octeontx2_gti_wdt_percpu_priv __percpu *percpu_priv; };
> > +
> > +static int octeontx2_gti_wdt_get_cpuid(struct watchdog_device *wdev)
> > +{
> > +	struct octeontx2_gti_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +	struct octeontx2_gti_wdt_percpu_priv *percpu_priv;
> > +	int cpu;
> > +
> > +	for_each_online_cpu(cpu) {
> > +		percpu_priv =3D per_cpu_ptr(priv->percpu_priv, cpu);
> > +		if (&percpu_priv->wdev =3D=3D wdev)
> > +			return cpu;
> > +	}
> > +
> > +	return -1;
> > +}
> > +
> > +void octeontx2_gti_wdt_callback_other_cpus(void *unused) {
> > +	struct pt_regs *regs =3D get_irq_regs();
> > +
> > +	pr_emerg("GTI Watchdog CPU:%d\n", raw_smp_processor_id());
> > +
> > +	if (regs)
> > +		show_regs(regs);
> > +	else
> > +		dump_stack();
> > +}
> > +
> > +static irqreturn_t octeontx2_gti_wdt_interrupt(int irq, void *data) {
> > +	struct octeontx2_gti_wdt_priv *priv =3D (struct octeontx2_gti_wdt_pri=
v
> *)data;
> > +	int cpu =3D smp_processor_id();
> > +
> > +	/* Clear interrupt to fire again if delayed poke happens */
> > +	writeq(1 << cpu, priv->base + GTI_CWD_INT);
> > +	dump_stack();
> > +
> > +	for_each_online_cpu(cpu) {
> > +		if (cpu =3D=3D raw_smp_processor_id())
> > +			continue;
> > +
> > +		smp_call_function_single(cpu,
> > +
> octeontx2_gti_wdt_callback_other_cpus,
> > +					 NULL, 1);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int octeontx2_gti_wdt_ping(struct watchdog_device *wdev) {
> > +	struct octeontx2_gti_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +	int cpu =3D octeontx2_gti_wdt_get_cpuid(wdev);
> > +
> > +	if (cpu < 0)
> > +		return -EINVAL;
> > +
> > +	writeq(1, priv->base + GTI_CWD_POKE(cpu));
> > +	return 0;
> > +}
> > +
> > +static int octeontx2_gti_wdt_start(struct watchdog_device *wdev) {
> > +	struct octeontx2_gti_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +	int cpu =3D octeontx2_gti_wdt_get_cpuid(wdev);
> > +	u64 regval;
> > +
> > +	if (cpu < 0)
> > +		return -EINVAL;
> > +
> > +	set_bit(WDOG_HW_RUNNING, &wdev->status);
> > +
> > +	/* Clear any pending interrupt */
> > +	writeq(1 << cpu, priv->base + GTI_CWD_INT);
> > +
> > +	/* Enable Interrupt */
> > +	writeq(1 << cpu, priv->base + GTI_CWD_INT_ENA_SET);
> > +
> > +	/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode *=
/
> > +	regval =3D readq(priv->base + GTI_CWD_WDOG(cpu));
> > +	regval |=3D GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
> > +	writeq(regval, priv->base + GTI_CWD_WDOG(cpu));
> > +
> > +	return 0;
> > +}
> > +
> > +static int octeontx2_gti_wdt_stop(struct watchdog_device *wdev) {
> > +	struct octeontx2_gti_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +	u64 regval;
> > +	int cpu =3D octeontx2_gti_wdt_get_cpuid(wdev);
> > +
> > +	if (cpu < 0)
> > +		return -EINVAL;
> > +
> > +	/* Disable Interrupt */
> > +	writeq(1 << cpu, priv->base + GTI_CWD_INT_ENA_CLR);
> > +
> > +	/* Set GTI_CWD_WDOG.Mode =3D 0 to stop the timer */
> > +	regval =3D readq(priv->base + GTI_CWD_WDOG(cpu));
> > +	regval &=3D ~GTI_CWD_WDOG_MODE_MASK;
> > +	writeq(regval, priv->base + GTI_CWD_WDOG(cpu));
> > +
> > +	return 0;
> > +}
> > +
> > +static int octeontx2_gti_wdt_settimeout(struct watchdog_device *wdev,
> > +					unsigned int timeout)
> > +{
> > +	struct octeontx2_gti_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +	int cpu =3D octeontx2_gti_wdt_get_cpuid(wdev);
> > +	u64 timeout_wdog, regval;
> > +
> > +	if (cpu < 0)
> > +		return -EINVAL;
> > +
> > +	/* Update new timeout */
> > +	wdev->timeout =3D timeout;
> > +
> > +	/* Get clock cycles from timeout in second */
> > +	timeout_wdog =3D (u64)timeout * priv->clock_freq;
> > +
> > +	/* Watchdog counts in 1024 cycle steps */
> > +	timeout_wdog =3D timeout_wdog >> 10;
> > +
> > +	/*
> > +	 * Hardware allows programming of upper 16-bits of 24-bits cycles
> > +	 * Round up and use upper 16-bits only.
> > +	 * Set max if timeout more than h/w supported
> > +	 */
> > +	timeout_wdog =3D (timeout_wdog + 0xff) >> 8;
> > +	if (timeout_wdog >=3D 0x10000)
> > +		timeout_wdog =3D 0xffff;
> > +
> > +	/*
> > +	 * GTI_CWD_WDOG.LEN have only upper 16-bits of 24-bits
> > +	 * GTI_CWD_WDOG.CNT, need addition shift of 8.
> > +	 */
> > +	regval =3D readq(priv->base + GTI_CWD_WDOG(cpu));
> > +	regval &=3D GTI_CWD_WDOG_MODE_MASK;
> > +	regval |=3D ((timeout_wdog) << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
> > +		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
> > +	writeq(regval, priv->base + GTI_CWD_WDOG(cpu));
> > +	return 0;
> > +}
> > +
> > +static const struct watchdog_info octeontx2_gti_wdt_ident =3D {
> > +	.identity =3D "OcteonTX2 GTI watchdog",
> > +	.options	=3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> WDIOF_MAGICCLOSE |
> > +			  WDIOF_CARDRESET,
> > +};
> > +
> > +static const struct watchdog_ops octeontx2_gti_wdt_ops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.start =3D octeontx2_gti_wdt_start,
> > +	.stop =3D octeontx2_gti_wdt_stop,
> > +	.ping =3D octeontx2_gti_wdt_ping,
> > +	.set_timeout =3D octeontx2_gti_wdt_settimeout, };
> > +
> > +static void octeontx2_gti_wdt_free_irqs(struct octeontx2_gti_wdt_priv
> > +*priv) {
> > +	struct octeontx2_gti_wdt_percpu_priv *percpu_priv;
> > +	int irq, cpu =3D 0;
> > +
> > +	for_each_online_cpu(cpu) {
> > +		percpu_priv =3D per_cpu_ptr(priv->percpu_priv, cpu);
> > +		irq =3D percpu_priv->irq;
> > +		if (irq) {
> > +			if (priv->is_nmi) {
> > +				disable_nmi_nosync(irq);
> > +				free_nmi(irq, priv);
> > +			} else {
> > +				disable_irq_nosync(irq);
> > +				free_irq(irq, priv);
> > +			}
> > +
> > +			percpu_priv->irq =3D 0;
> > +		}
> > +	}
> > +}
> > +
> > +static int octeontx2_gti_wdt_probe(struct platform_device *pdev) {
> > +	struct octeontx2_gti_wdt_percpu_priv *percpu_priv;
> > +	struct octeontx2_gti_wdt_priv *priv;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct watchdog_device *wdog_dev;
> > +	unsigned long irq_flags;
> > +	int irq, cpu, num_irqs;
> > +	int err;
> > +
> > +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->percpu_priv =3D devm_alloc_percpu(&pdev->dev, *priv-
> >percpu_priv);
> > +	if (!priv->percpu_priv)
> > +		return -ENOMEM;
> > +
> > +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
> > +			      "reg property not valid/found\n");
> > +
> > +	num_irqs =3D platform_irq_count(pdev);
> > +	if (num_irqs < 0)
> > +		return dev_err_probe(dev, num_irqs, "GTI CWD no IRQs\n");
> > +
> > +	if (num_irqs < num_online_cpus())
> > +		return dev_err_probe(dev, -EINVAL, "IRQs (%d) < CPUs (%d)\n",
> > +				     num_irqs, num_online_cpus());
> > +
> > +	priv->clock_freq =3D arch_timer_get_cntfrq();
> > +
> > +	for_each_online_cpu(cpu) {
>=20
> Watchdogs are supposed to be per system, not per CPU. The Linux kernel ha=
s
> other means to detect hung CPUs, and the watchdog subsystem should be
> (ab)used to bypass or replace those methods.

Sorry for late reply, just returned from vacation.

Okay, will remove the per core watchdog and submit next patch for global wa=
tchdog.

Thanks
-Bharat

>=20
> I am not inclined to accept this patch.
>=20
> Guenter
>=20
> > +		percpu_priv =3D per_cpu_ptr(priv->percpu_priv, cpu);
> > +		wdog_dev =3D &percpu_priv->wdev;
> > +		wdog_dev->info =3D &octeontx2_gti_wdt_ident,
> > +		wdog_dev->ops =3D &octeontx2_gti_wdt_ops,
> > +		wdog_dev->parent =3D dev;
> > +		wdog_dev->min_timeout =3D 1;
> > +		wdog_dev->max_timeout =3D 16;
> > +		wdog_dev->max_hw_heartbeat_ms =3D 16000;
> > +		wdog_dev->timeout =3D 8;
> > +
> > +		irq =3D platform_get_irq(pdev, cpu);
> > +		if (irq < 0) {
> > +			dev_err(&pdev->dev, "IRQ resource not found\n");
> > +			err =3D -ENODEV;
> > +			goto out;
> > +		}
> > +
> > +		err =3D irq_force_affinity(irq, cpumask_of(cpu));
> > +		if (err) {
> > +			pr_warn("unable to set irq affinity (irq=3D%d, cpu=3D%u)\n",
> irq, cpu);
> > +			goto out;
> > +		}
> > +
> > +		irq_flags =3D IRQF_PERCPU | IRQF_NOBALANCING |
> IRQF_NO_AUTOEN |
> > +			    IRQF_NO_THREAD;
> > +		err =3D request_nmi(irq, octeontx2_gti_wdt_interrupt, irq_flags,
> > +				  pdev->name, priv);
> > +		if (err) {
> > +			err =3D request_irq(irq, octeontx2_gti_wdt_interrupt,
> irq_flags,
> > +					  pdev->name, priv);
> > +			if (err) {
> > +				dev_err(dev, "cannot register interrupt handler
> %d\n", err);
> > +				goto out;
> > +			}
> > +			enable_irq(irq);
> > +		} else {
> > +			priv->is_nmi =3D 1;
> > +			enable_nmi(irq);
> > +		}
> > +
> > +		percpu_priv->irq =3D irq;
> > +		watchdog_set_drvdata(wdog_dev, priv);
> > +		platform_set_drvdata(pdev, priv);
> > +		watchdog_init_timeout(wdog_dev, wdog_dev->timeout, dev);
> > +		octeontx2_gti_wdt_settimeout(wdog_dev, wdog_dev-
> >timeout);
> > +		watchdog_stop_on_reboot(wdog_dev);
> > +		watchdog_stop_on_unregister(wdog_dev);
> > +
> > +		err =3D devm_watchdog_register_device(dev, wdog_dev);
> > +		if (unlikely(err))
> > +			goto out;
> > +		dev_info(dev, "Watchdog enabled (timeout=3D%d sec)",
> wdog_dev->timeout);
> > +	}
> > +	return 0;
> > +
> > +out:
> > +	octeontx2_gti_wdt_free_irqs(priv);
> > +	return err;
> > +}
> > +
> > +static int octeontx2_gti_wdt_remove(struct platform_device *pdev) {
> > +	struct octeontx2_gti_wdt_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +	octeontx2_gti_wdt_free_irqs(priv);
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id octeontx2_gti_wdt_of_match[] =3D {
> > +	{ .compatible =3D "mrvl,octeontx2-gti-wdt", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, octeontx2_gti_wdt_of_match);
> > +
> > +static struct platform_driver octeontx2_gti_wdt_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "octeontx2-gti-wdt",
> > +		.of_match_table =3D octeontx2_gti_wdt_of_match,
> > +	},
> > +	.probe =3D octeontx2_gti_wdt_probe,
> > +	.remove =3D octeontx2_gti_wdt_remove,
> > +};
> > +module_platform_driver(octeontx2_gti_wdt_driver);
> > +
> > +MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
> > +MODULE_DESCRIPTION("OcteonTX2 GTI per cpu watchdog driver");
> > --
> > 2.17.1
> >
