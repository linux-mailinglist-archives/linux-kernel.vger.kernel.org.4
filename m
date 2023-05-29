Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD947143FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjE2GOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjE2GOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:14:40 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BA3D2;
        Sun, 28 May 2023 23:14:32 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34SN0VhR007380;
        Sun, 28 May 2023 23:14:10 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3quf7pd7ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 May 2023 23:14:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhZ/PiP/BkwxlkjG4/yFNJcWYTIfPdlD+fum2a37ruggCvt3QVqNtowFpeODM78DHspeyfr4TItZahDzhp9fW6yA1e+vFOnTL5WVPeXegsJ9wPjICzsi8h8RBar1vgxDF0lrFIL/YbxF2kcq3oRgX2E1B4+oOMXS2ZxeTM2uy2/U9bWzg7klK7OfeyN0QgquyCQwpnbAFoNdPsyBIt71OTW2dMVZz+PcnniFZnM+f6/Dm+oFdmePBDIcPI28TOn8nhFLCjr5Jea4drIVPT2nuIC3KP4GdTtAzQBt53IJDr4PN9DKmehCi9Wgfo9xJ2lbBTVctGQbpKaTjNdwuMUbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Lj3NwmjxrhUjSv6HxhymKUHqosfpOuh9jBmDrH2Dbo=;
 b=lrVWZgAAACpLPKdp6qAe7E71jJlcjfiQ5UvWGoOg+iGIgv9+QVuOqljil1hvly/LlIFq/EMlKDmyRIQ9RNpHB1rvgWIORXtrIDR7chc2ZMj62GMYQFjitogKLM1xCEvdGriH/pqH6A8QbTI6mJV7m1fpx/SjPwZf3i43JCgOerhmJuaLScAjv9B4YvF1Vp8qYULen802PQ8bLkXJAE9CKdJoc9DYY053969MaB/GaiI/1u2/4SrWxzDJT10SXdrfWcB4aJTwnMKgRDqS7kw897rO2N8s21VcOo1YVP3XE/c9ci9pfXf061HzicKli1ilAs99qo4h9igmo84WJYGYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Lj3NwmjxrhUjSv6HxhymKUHqosfpOuh9jBmDrH2Dbo=;
 b=uC+8zNE+4zLeeFWfGGHCnSul/76DvIjYVPHrGS0Pi1NQRBmDDKTyFfSmEB0BHCZEH6NZFxw9DCFUIDtHxCMkSd/SDAGj7j9PPwFFOkTmerDErkyN5GVq3qluZ5KlP91MEt6x3t3J5JEd/G7HBMk7iYZqtAbS+aGEPce7+zwitxI=
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com (2603:10b6:4:62::23)
 by BL1PR18MB4341.namprd18.prod.outlook.com (2603:10b6:208:30b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 06:14:08 +0000
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::8728:7063:8550:fa8c]) by DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::8728:7063:8550:fa8c%5]) with mapi id 15.20.6433.020; Mon, 29 May 2023
 06:14:07 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Conor Dooley <conor@kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: RE: [EXT] Re: [PATCH 1/2 v8] dt-bindings: watchdog: marvell GTI
 system watchdog driver
Thread-Topic: [EXT] Re: [PATCH 1/2 v8] dt-bindings: watchdog: marvell GTI
 system watchdog driver
Thread-Index: AQHZj5sOTdsKm/MUPEiPdp8HUff0C69s87YAgAE8q+CAABvLAIACfT1A
Date:   Mon, 29 May 2023 06:14:07 +0000
Message-ID: <DM5PR1801MB1883D475F396D2CBA02B6D91E34A9@DM5PR1801MB1883.namprd18.prod.outlook.com>
References: <20230526062626.1180-1-bbhushan2@marvell.com>
 <20230526-bondless-slather-5de0a5659353@spud>
 <DM5PR1801MB188350DD9CFDBB3E240AC838E3449@DM5PR1801MB1883.namprd18.prod.outlook.com>
 <20230527-wiring-coping-88eba4d91f3f@spud>
In-Reply-To: <20230527-wiring-coping-88eba4d91f3f@spud>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYmJodXNoYW4y?=
 =?us-ascii?Q?XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0?=
 =?us-ascii?Q?YmEyOWUzNWJcbXNnc1xtc2ctMDI1ZGFkNmEtZmRlOC0xMWVkLWFlN2YtMDRi?=
 =?us-ascii?Q?OWUzMzM4ZjZlXGFtZS10ZXN0XDAyNWRhZDZjLWZkZTgtMTFlZC1hZTdmLTA0?=
 =?us-ascii?Q?YjllMzMzOGY2ZWJvZHkudHh0IiBzej0iNDI0MiIgdD0iMTMzMjk4MTQ0NDQy?=
 =?us-ascii?Q?NjU1ODMyIiBoPSJscXlHSXpqTTNhRjE5dlR1b0trczBjRkYxUkU9IiBpZD0i?=
 =?us-ascii?Q?IiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFHSVdB?=
 =?us-ascii?Q?QUJZSkxuRTlKSFpBYUdBNjFrSXVxamJvWURyV1FpNnFOc1pBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBSEFBQUFCdUR3QUEzZzhBQUlRR0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBUUVCQUFBQUk3cVRwQUNBQVFBQUFBQUFBQUFBQUo0QUFBQmhBR1FB?=
 =?us-ascii?Q?WkFCeUFHVUFjd0J6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFj?=
 =?us-ascii?Q?QUJsQUhJQWN3QnZBRzRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJn?=
 =?us-ascii?Q?QjFBRzBBWWdCbEFISUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFI?=
 =?us-ascii?Q?VUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFaQUJoQUhNQWFBQmZBSFlBTUFB?=
 =?us-ascii?Q?eUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNn?=
 =?us-ascii?Q?QmtBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFH?=
 =?us-ascii?Q?MEFYd0J6QUhNQWJnQmZBRzRBYndCa0FHVUFiQUJwQUcwQWFRQjBBR1VBY2dC?=
 =?us-ascii?Q?ZkFIWUFNQUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFB?=
 =?us-ascii?Q?QUFBQUlBQUFBQUFKNEFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4?=
 =?us-ascii?Q?QWN3QndBR0VBWXdCbEFGOEFkZ0F3QURJQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHUUFiQUJ3QUY4QWN3QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBB?=
 =?us-ascii?Q?WlFCekFITUFZUUJuQUdVQVh3QjJBREFBTWdBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWkFCc0FIQUFYd0J6?=
 =?us-ascii?Q?QUd3QVlRQmpBR3NBWHdCakFHZ0FZUUIwQUY4QWJRQmxBSE1BY3dCaEFHY0Fa?=
 =?us-ascii?Q?UUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmtBR3dBY0FC?=
 =?us-ascii?Q?ZkFIUUFaUUJoQUcwQWN3QmZBRzhBYmdCbEFHUUFjZ0JwQUhZQVpRQmZBR1lB?=
 =?us-ascii?Q?YVFCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdVQWJRQmhBR2tBYkFCZkFHRUFaQUJr?=
 =?us-ascii?Q?QUhJQVpRQnpBSE1BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUN3QUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?us-ascii?Q?RjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFR?=
 =?us-ascii?Q?QmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFE?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFI?=
 =?us-ascii?Q?TUFYd0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QVlRQnNBRzhBYmdC?=
 =?us-ascii?Q?bEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNB?=
 =?us-ascii?Q?QnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhR?=
 =?us-ascii?Q?QWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFCbEFITUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdFQWNnQnRBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFad0J2QUc4QVp3?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBWXdC?=
 =?us-ascii?Q?dkFHUUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3?=
 =?us-ascii?Q?QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFYd0Jr?=
 =?us-ascii?Q?QUdrQVl3QjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhB?=
 =?us-ascii?Q?YWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtB?=
 =?us-ascii?Q?R1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFi?=
 =?us-ascii?Q?Z0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFBYVFCaEFH?=
 =?us-ascii?Q?d0FYd0J0QUdFQWNnQjJBR1VBYkFCc0FGOEFid0J5QUY4QVlRQnlBRzBBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFB?=
 =?us-ascii?Q?WHdCdUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBB?=
 =?us-ascii?Q?R0VBYkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JuQUc4QWJ3?=
 =?us-ascii?Q?Qm5BR3dBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFj?=
 =?us-ascii?Q?d0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndB?=
 =?us-ascii?Q?SElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFjZ0JsQUhNQWRB?=
 =?us-ascii?Q?QnlBR2tBWXdCMEFHVUFaQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJ?=
 =?us-ascii?Q?QVh3QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhRQVpRQnlBRzBBYVFCdUFI?=
 =?us-ascii?Q?VUFjd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCc0FGOEFkd0J2QUhJQVpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUN3QUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBaEFZQUFBQUFBQUFjQUFBQUFRQUFBQUFBQUFE?=
 =?us-ascii?Q?OFhOeUFuUlFtUW9MNnlDenJYRVlJSEFBQUFB?=
x-dg-reffive: =?us-ascii?Q?RUFBQUFBQUFBQTEwZ2ZjYjFMc2tlUE9yNUh2UEUxcXlvQUFBQUJBQUFBSWdB?=
 =?us-ascii?Q?QUFBQUFBQUJqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdFQWJBQUFBQm9H?=
 =?us-ascii?Q?QUFBWkFBQUFHQUFBQUFBQUFBQmhBR1FBWkFCeUFHVUFjd0J6QUFBQUpBQUFB?=
 =?us-ascii?Q?QUFBQUFCakFIVUFjd0IwQUc4QWJRQmZBSEFBWlFCeUFITUFid0J1QUFBQUxn?=
 =?us-ascii?Q?QUFBQUFBQUFCakFIVUFjd0IwQUc4QWJRQmZBSEFBYUFCdkFHNEFaUUJ1QUhV?=
 =?us-ascii?Q?QWJRQmlBR1VBY2dBQUFEQUFBQUFBQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J6?=
 =?us-ascii?Q?QUhNQWJnQmZBR1FBWVFCekFHZ0FYd0IyQURBQU1nQUFBREFBQUFBQUFBQUFZ?=
 =?us-ascii?Q?d0IxQUhNQWRBQnZBRzBBWHdCekFITUFiZ0JmQUdzQVpRQjVBSGNBYndCeUFH?=
 =?us-ascii?Q?UUFjd0FBQUQ0QUFBQUFBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QnpBSE1BYmdC?=
 =?us-ascii?Q?ZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFjZ0JmQUhZQU1BQXlBQUFB?=
 =?us-ascii?Q?TWdBQUFBQUFBQUJqQUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QWN3QndB?=
 =?us-ascii?Q?R0VBWXdCbEFGOEFkZ0F3QURJQUFBQStBQUFBQUFBQUFHUUFiQUJ3QUY4QWN3?=
 =?us-ascii?Q?QnJBSGtBY0FCbEFGOEFZd0JvQUdFQWRBQmZBRzBBWlFCekFITUFZUUJuQUdV?=
 =?us-ascii?Q?QVh3QjJBREFBTWdBQUFEWUFBQUFBQUFBQVpBQnNBSEFBWHdCekFHd0FZUUJq?=
 =?us-ascii?Q?QUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFBQUFEZ0FB?=
 =?us-ascii?Q?QUFBQUFBQVpBQnNBSEFBWHdCMEFHVUFZUUJ0QUhNQVh3QnZBRzRBWlFCa0FI?=
 =?us-ascii?Q?SUFhUUIyQUdVQVh3Qm1BR2tBYkFCbEFBQUFKQUFBQUFzQUFBQmxBRzBBWVFC?=
 =?us-ascii?Q?cEFHd0FYd0JoQUdRQVpBQnlBR1VBY3dCekFBQUFXQUFBQUFNQUFBQnRBR0VB?=
 =?us-ascii?Q?Y2dCMkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxB?=
 =?us-ascii?Q?SE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFiQUJmQUdFQWJB?=
 =?us-ascii?Q?QnZBRzRBWlFBQUFGUUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QUhJ?=
 =?us-ascii?Q?QWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBY2dCbEFITUFkQUJ5?=
 =?us-ascii?Q?QUdrQVl3QjBBR1VBWkFCZkFHRUFiQUJ2QUc0QVpRQUFBRm9BQUFBQUFBQUFi?=
 =?us-ascii?Q?UUJoQUhJQWRnQmxBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFH?=
 =?us-ascii?Q?MEFaUUJ6QUY4QWNnQmxBSE1BZEFCeUFHa0FZd0IwQUdVQVpBQmZBR2dBWlFC?=
 =?us-ascii?Q?NEFHTUFid0JrQUdVQWN3QUFBQ0FBQUFBQUFB?=
x-dg-refsix: =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHRUFjZ0J0QUFBQUpnQUFBQUFBQUFC?=
 =?us-ascii?Q?dEFHRUFjZ0IyQUdVQWJBQnNBRjhBWndCdkFHOEFad0JzQUdVQUFBQTBBQUFB?=
 =?us-ascii?Q?QUFBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBB?=
 =?us-ascii?Q?RjhBWXdCdkFHUUFaUUJ6QUFBQVBnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJB?=
 =?us-ascii?Q?QnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBR01BYndCa0FHVUFjd0JmQUdR?=
 =?us-ascii?Q?QWFRQmpBSFFBQUFCZUFBQUFBQUFBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3?=
 =?us-ascii?Q?QUhJQWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFa?=
 =?us-ascii?Q?Z0JwQUdRQVpRQnVBSFFBYVFCaEFHd0FYd0J0QUdFQWNnQjJBR1VBYkFCc0FB?=
 =?us-ascii?Q?QUFiQUFBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtBR1VB?=
 =?us-ascii?Q?YmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNnQmZB?=
 =?us-ascii?Q?R0VBY2dCdEFBQUFjZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNB?=
 =?us-ascii?Q?QnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZ?=
 =?us-ascii?Q?QWFRQmtBR1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJm?=
 =?us-ascii?Q?QUc4QWNnQmZBR2NBYndCdkFHY0FiQUJsQUFBQVdnQUFBQUFBQUFCdEFHRUFj?=
 =?us-ascii?Q?Z0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFH?=
 =?us-ascii?Q?VUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJzQUFBQWFBQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhB?=
 =?us-ascii?Q?Y0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpB?=
 =?us-ascii?Q?SFFBY2dCcEFHTUFkQUJsQUdRQVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4QWJ3?=
 =?us-ascii?Q?QnlBRjhBWVFCeUFHMEFBQUFxQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUd3?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFHa0FiZ0IxQUhNQUFBQWlBQUFBTEFBQUFHMEFZUUJ5?=
 =?us-ascii?Q?QUhZQVpRQnNBR3dBWHdCM0FHOEFjZ0JrQUFBQSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-dg-tag-bcast: {BB38C8B4-BBDA-40C5-8168-0013E523D1A2}
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1801MB1883:EE_|BL1PR18MB4341:EE_
x-ms-office365-filtering-correlation-id: 4813c233-9a40-4e64-0444-08db600be922
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sx7DuGYPEfsSdw1uwalPTy2g6RpJk23vzxWQXW2SNXomNt32clShAAZe3EMUSY5LAibOyxD4C42V9nckKERleaza/vVQkbdglIgJYI5zB0QeYwV0DTKO3bA4JTRJn3qC7rijuEpssFoAK+KKG4jW17PPiK7RQikyNsxcQ4SOT0bYWYpKPSo0MSfwsG2HpwleS5kdPDZupDCtniIFmX9H1nHlpk73+GC4/BNfmxfZNbbYAfjEOBN+G5GP07UvEbeUo2xma/EvcMOGQW0VRxoWzgziZs0mVc/2Y0aTAewWGnOqWjQUdFk5POohMbGj/R9n7SGVufi56mOZyafIC0bgXJaks193tTa8nN2vXVtA4t9mQin+/JGjrb32inmvXQ7WDC3s3tJ3krKkorUdT96kquil5uGydMVy/5NbizJyjo9daxue0qEEqsd6vne7OdUwc9gcs1o8w7lOENzaTAXKGuimxhJC0ajTVOjKHBMxdZOurhQERNCpKKK9+fiBkJevnHD+DK8jPbVWWb6Ot9/oa/GDokH4l06FIGHc1T3GQ4gVqZ4zIfw3wRIFUKf224FQGcMsLokCXW4YTJnX+fdUisoT2vKOjQJWSQ1whKBNiV3AFGBGVG7raGcTCm8ijdmZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB1883.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(7696005)(86362001)(41300700001)(38070700005)(55016003)(6916009)(4326008)(71200400001)(316002)(33656002)(66446008)(66476007)(66556008)(64756008)(66946007)(76116006)(107886003)(52536014)(5660300002)(186003)(2906002)(53546011)(9686003)(6506007)(26005)(83380400001)(38100700002)(478600001)(54906003)(8676002)(122000001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9DxjHPVUIwvcNm2o5EeQl9d/YMdfdVjlQ0Ne2MXhve5deqFurmg0MwDvH5N1?=
 =?us-ascii?Q?LbILEb9Q1uiYE0aka4ZwZORZFhbiZtUD9N5tUNyLEN5TdzaowTQajX+g6sXo?=
 =?us-ascii?Q?JtMP6RpLUyBPeegGSyPL10aBk/mQkZlegPI61uHmS9visxpLSOVdxd+wJUoI?=
 =?us-ascii?Q?I9Brvh9pPthTi47Bx4v2BXY3LzgtDrYv8MrzPDmnyim+lWhWMAhmm4pB8NmJ?=
 =?us-ascii?Q?Cjtp6BGh3FIAx/jw9lpXV/mVZb/MXoPQPhv7DE4D5TcMsyNWcdCmOsouMS58?=
 =?us-ascii?Q?7vz3C0tUR13DbGNqY4gLB3d6YgHEvyRrfT7tmtpnS5CjspgY3a0pdivW/oQv?=
 =?us-ascii?Q?xvb/+MdYIYO58meUHHmul71ELASj0JHML1Sdw+R0WjyrEGgnJUuVjeJx62He?=
 =?us-ascii?Q?xVaPktUYR9U9fTYp/Z9+Mlo9/OF1KtEq35ycuXMD/bBheq9zJiNqnTJs29Df?=
 =?us-ascii?Q?9GQkV06f3kwKcdC1j36De+OClYnBpAxqcchqt1C2vzzFqC6CZPJzPoqbe8w9?=
 =?us-ascii?Q?P6KJ11BUzHRzjDIhP2F2o+HLqVzSPobGUjUtoCQh0Mn3l5zhPYVXWzRXih9Z?=
 =?us-ascii?Q?qaiPO2Vpw36IYMII3b6eYQ8R0Tw9QY5PGt+7HaOoJWje3J6Ovli4AHCqwQc4?=
 =?us-ascii?Q?oMbJbmkTR4/FojbFEWpJCOeIG+8ULavxpmM++STDO4sOukro6MXgmUvowLgg?=
 =?us-ascii?Q?HnaiCo8gF1LCL7YOZqsG8pbIdJHdfhvt6MM44Y0rXxYCDPMtbq4aRroVYvgu?=
 =?us-ascii?Q?O8dGQwLhekRUig8PuGSPXZmSrGy8dxk93sqFHSZn25Pd6fDLDCTfctGeESdt?=
 =?us-ascii?Q?LvB20bRGtpUeITUC/l++cZXON1A/F4Cj8busjgrI/M4MugbwVdt/A19UnlJ+?=
 =?us-ascii?Q?pD6q2I31UNr43Qi7PU/uoT7YYGblFXmjX12/37HeX16sCIPfv1a75YVNktjS?=
 =?us-ascii?Q?AXMnVWIW+ADR30HaAqzUrVsuusNBXFZ59JDVR7qXHJF8UOETfrAcECjS40IM?=
 =?us-ascii?Q?7cvkSinX3RAuntYn2CTWIzn6LUr2wg+F7DyxjiewMrxjvOutregaSyVtUbyx?=
 =?us-ascii?Q?Zd70bHldj9xgCuvPrwcP+9MoiZDFRGknIH5f8fJNmebUlVcIdcEVDb9JANNm?=
 =?us-ascii?Q?DjsPG0Nkzg4NvWmvJ0N2h7oZRV2cUaYMh05dw3m7SJ1U4FvKY5xJOTMqCBe5?=
 =?us-ascii?Q?zp8jJDBauiU8vJ69T95Syu4Fnhy1kf2NZo1FoDFjjxRFxIVxbtHLw+GkuLnd?=
 =?us-ascii?Q?zZ7rUMXVM4jNghgDmBUfILgze9aE6ewWWNs82MEu+RttI3pJQ7nh5zC0PsEy?=
 =?us-ascii?Q?HaXsJ1NcC+zYc5xJ1DkOr38k/B0dP2lL0rLqtysS684uKGiLl+2hH14eSHMZ?=
 =?us-ascii?Q?62rDEejjrJPCbYWLLvV3SDYFewshXuAMBbnPfHtzlVORnoqdwp7ssJ285cAn?=
 =?us-ascii?Q?cTI0vZfAourSAp/fJ9j7/6dbPcJzL3HkVy8zNQpkBvurxpLmvgimmce0OzWm?=
 =?us-ascii?Q?lUFt002AI8LEVCw6PUtto8dAqkOTAzaKPJBQIyrMJ/9r73HGhQiVcpSF5/Zb?=
 =?us-ascii?Q?97lvsTo/hKJ5cbdJmReuikv7Lt1BW17UKw3MKwQs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB1883.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4813c233-9a40-4e64-0444-08db600be922
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 06:14:07.4699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5W2YkRnykXI+gh+/0mZbXYRVd1le3pfnyTN5nIp1bzVw19cZsa+iYxCFs8SRFO2thOK80YOxBaHIblYLGp8HDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4341
X-Proofpoint-GUID: cU_WD07jTUy9xYHgv2CoQdDm-O7TyvgY
X-Proofpoint-ORIG-GUID: cU_WD07jTUy9xYHgv2CoQdDm-O7TyvgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_03,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please see inline

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Saturday, May 27, 2023 9:40 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: wim@linux-watchdog.org; linux@roeck-us.net; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-watchdog@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Sunil Kovvuri
> Goutham <sgoutham@marvell.com>
> Subject: Re: [EXT] Re: [PATCH 1/2 v8] dt-bindings: watchdog: marvell GTI =
system
> watchdog driver
>=20
> On Sat, May 27, 2023 at 02:53:25PM +0000, Bharat Bhushan wrote:
> > From: Conor Dooley <conor@kernel.org>
> > > On Fri, May 26, 2023 at 11:56:25AM +0530, Bharat Bhushan wrote:
>=20
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - marvell,cn9670-wdt
> > > > +      - marvell,cn9880-wdt
> > > > +      - marvell,cnf9535-wdt
> > > > +      - marvell,cn10624-wdt
> > > > +      - marvell,cn10308-wdt
> > > > +      - marvell,cnf10518-wdt
> > >
> > > static const struct of_device_id gti_wdt_of_match[] =3D {
> > >        { .compatible =3D "marvell,cn9670-wdt", .data =3D &match_data_=
octeontx2},
> > >        { .compatible =3D "marvell,cn9880-wdt", .data =3D &match_data_=
octeontx2},
> > >        { .compatible =3D "marvell,cnf9535-wdt", .data =3D &match_data=
_octeontx2},
> > >        { .compatible =3D "marvell,cn10624-wdt", .data =3D &match_data=
_cn10k},
> > >        { .compatible =3D "marvell,cn10308-wdt", .data =3D &match_data=
_cn10k},
> > >        { .compatible =3D "marvell,cnf10518-wdt", .data =3D
> > > &match_data_cn10k},
> > >
> > > This is a fat hint that you should be using fallback compatibles here=
.
> > > You even had a fallback setup in your last revision, but you seem to
> > > have removed it alongside the removal of the wildcards. Why did you d=
o
> that?
> >
> > Not sure I understand this comment, Compatible in last version was as b=
elow:
> >
> > + properties:
> > + compatible:
> > +    oneOf:
> > +      - const: marvell,octeontx2-wdt
> > +      - items:
> > +          - enum:
> > +              - marvell,octeontx2-95xx-wdt
> > +              - marvell,octeontx2-96xx-wdt
> > +              - marvell,octeontx2-98xx-wdt
> > +          - const: marvell,octeontx2-wdt
> > +      - const: marvell,cn10k-wdt
> > +      - items:
> > +          - enum:
> > +              - marvell,cn10kx-wdt
> > +              - marvell,cnf10kx-wdt
> > +          - const: marvell,cn10k-wdt
> >
> > By fallback do you mean " const: marvell,cn10k-wdt" and
> > "const: marvell,octeontx2-wdt" ? If yes I removed because "octeontx2"
> > and "cn10k" are soc family name and no a specific soc.
>=20
> No, I meant that you should permit
> 	compatible =3D "marvell,cn9880-wdt", "marvell,cn9670-wdt"; and
> 	compatible =3D "marvell,cnf9535-wdt", "marvell,cn9670-wdt"; and
> 	compatible =3D "marvell,cn9670-wdt";
> so the driver only needs to contain
> 	{ .compatible =3D "marvell,cn9670-wdt", .data =3D &match_data_octeontx2}=
,
> instead of
> 	{ .compatible =3D "marvell,cn9670-wdt", .data =3D &match_data_octeontx2}=
,
> 	{ .compatible =3D "marvell,cn9880-wdt", .data =3D &match_data_octeontx2}=
,
> 	{ .compatible =3D "marvell,cnf9535-wdt", .data =3D &match_data_octeontx2=
},
>=20
> Note that using fallback compatibles is separate from using wildcards, an=
d I was
> not suggesting that you go back to wildcards ;)

Fallback you mentioned make code look simple. Is below representation corre=
ct for above mentioned fallback?=20

properties:
  compatible:
    oneOf:
      - const: marvell,cn9670-wdt
      - items:
          - enum:
              - marvell,cn9880-wdt
              - marvell,cnf9535-wdt
          - const: marvell,cn9670-wdt
      - const: marvell,cn10624-wdt
      - items:
          - enum:
              - marvell,cn10308-wdt
              - marvell,cnf10518-wdt
          - const: marvell,cn10624-wdt


And driver will have
        { .compatible =3D "marvell,cn9670-wdt", .data =3D &match_data_octeo=
ntx2},
        { .compatible =3D "marvell,cn10624-wdt", .data =3D &match_data_cn10=
k},


Thanks
-Bharat

>=20
> Cheers,
> Conor.
