Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972776E476C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjDQMTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjDQMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:19:21 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2698B19A5;
        Mon, 17 Apr 2023 05:19:13 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H7qsdA011571;
        Mon, 17 Apr 2023 04:06:36 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3q12448yef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 04:06:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyoJQh7wmPaZ10EZ/cISaoARDmxybaFtxxfsfrPU83AgYZxkTJyZ+pFtgoVcJk3Sx6IKuIHTYrDOK8JvZeG0hR8K13O9p0KNzUVB7sAFtnIw0hko//J8srRwrObIqQvs3f6RTtVf0gOQIkXc65YTr4LP/6hMrxlosyhDepv2z/JCXf7z43N5nebAxM2tW5lCKfjokeqz6t/Klw/71BYYefqnLv2UUsTr9eat2cpdyDxxe2S5Ep3DENbZhXse9c86NsGvJyEe1ogZU0pZ0BnyxH50s/hGhPNampHupY9Z6B5aGxurTEHvtOLQQP6iPrqSh3xgVeshjVpSxkH+D/MOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXTw7TRfc0z/uvyFK/LHiVRMd6Hs31kuQr95rPYXPWM=;
 b=VPej8aHMcgpwDuGrYcjuOdVqb8HHP3HYlxxCyj5igDgCshR6ZA5lQtUsWh/KgkGR2W8t2E/raO4G1TDidpRm9zf4lOceGu0Vj38vgtFcSt3Kd4/tgHA2KcstTnIgLo3dQnHKHzuvcD+mQ0jiDH7wmSqOKWJIng3cmz1TWmxRlvk9E9c6nlrc6K1qZTARX2sB2PCTXrZhDTSBsRURfTFJdnjogVngyq5G+ut4hxU50PoPPGvkl6XsHZwgG6yRA48DmDEBfKC8E0iYtHSki/JQz+UgPeTM8zUsxBut/r4rki6FhII+RWHCtaXD7LnuMnkP8HPzPZlg4P/wC2s7/VopJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXTw7TRfc0z/uvyFK/LHiVRMd6Hs31kuQr95rPYXPWM=;
 b=NXqZUr3NksOeD2xEGLHo/dybiMHA/qrFR/jfe7fbB2Yu9WBCpT08kYQanVAk9IesdojbL7dDZ/464sKdl1HryXByQYxIQDBt7HRHd7SxN0NzuMkvGtQgiscfvFWM+AS73cBo46ihPm/kVQ+1oM85vaWL+RMS8JQN5Q8t+cX6yjI=
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com (2603:10b6:4:62::23)
 by CH0PR18MB4290.namprd18.prod.outlook.com (2603:10b6:610:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 11:06:34 +0000
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::e4d4:8770:3d35:1d13]) by DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::e4d4:8770:3d35:1d13%3]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 11:06:33 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog driver
Thread-Topic: [EXT] Re: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog
 driver
Thread-Index: AQHZbrs3Y5VJwNXLFkCR8g9jIrxgy68q3wQAgARfGaA=
Date:   Mon, 17 Apr 2023 11:06:33 +0000
Message-ID: <DM5PR1801MB188396A390171D72C6702021E39C9@DM5PR1801MB1883.namprd18.prod.outlook.com>
References: <20230414102342.23696-1-bbhushan2@marvell.com>
 <20230414102342.23696-2-bbhushan2@marvell.com>
 <b3087a0c-d079-4ccb-8202-593abb4a4d44@roeck-us.net>
In-Reply-To: <b3087a0c-d079-4ccb-8202-593abb4a4d44@roeck-us.net>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYmJodXNoYW4y?=
 =?us-ascii?Q?XGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0?=
 =?us-ascii?Q?YmEyOWUzNWJcbXNnc1xtc2ctZTZmMWIzNGYtZGQwZi0xMWVkLWFlN2EtNDgy?=
 =?us-ascii?Q?YWUzNzQwYjc2XGFtZS10ZXN0XGU2ZjFiMzUwLWRkMGYtMTFlZC1hZTdhLTQ4?=
 =?us-ascii?Q?MmFlMzc0MGI3NmJvZHkudHh0IiBzej0iMTQ4NDMiIHQ9IjEzMzI2MjAzMTkw?=
 =?us-ascii?Q?MzE0NzczOCIgaD0ieHpkTVpkd2lQeXVOZUhINHNEMWlja0R3WnJrPSIgaWQ9?=
 =?us-ascii?Q?IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBSFlJ?=
 =?us-ascii?Q?QUFEYVJxS3BISEhaQVNxMmZtYWNZeExuS3JaK1pweGpFdWNOQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: DM5PR1801MB1883:EE_|CH0PR18MB4290:EE_
x-ms-office365-filtering-correlation-id: 5ceeadcc-645d-4106-4340-08db3f33ce0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E239fVgg+YFi5M8I2XtyWpyb5yToOg8N5XZd4jcWgOwrggDmGykNPcRoBHFcoyJryOUYldHiCl+DfzkSFnBFhoXk4PRXxEOyq6eA4kSErYYio2x1et3iiqaidTGWTclNBt4sTlhDRJzNCYu6sgGweern/n07TRGmtLAvSEcKuzdYqTEfta5HbhFEJRTrH6j3pGNfqkBx0IsNly7URX1WyUFvoD3OTaUzNlzSMqWlN70vpJZTQDXjEl7dqvcXBkA3DNEiMO0PGOMWy/mrIAU1/4K/e3P11chMrv62Tqb9my+gjXZqOZ0LVXRCWWRRbFXJpZEE5K60beRXQiiXxSRDr0ys3M3tmmocjkUS6v+/FHOF5OWhwvAn4U15yhmWczOJhAJoI50GgwnVDNFSwLLulMqIVWb8PP54XMNGO2MUrkX006BUwyPEn+7t256I5LBHk8Cw6r9dZpuX2e5EGuxGhxqobkiUlRJZoTL8dS9U5PGLOJiYiBNA6qlBIpTdMJwQ4TmtOc/aKVXniOV3xExQivS9nxg7fH+Cu/YfSTjAp3Hl5LkPeBL6RT20U3liRy0GusP6OP2UnFy+rDyJDPRTYdrqa+c2/LKdN5xYze00jj2MsguU7aohkWjt8J2bH0rkPl8PZoGWXez+ShQeLgp+Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB1883.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(71200400001)(30864003)(33656002)(2906002)(5660300002)(122000001)(316002)(52536014)(38100700002)(38070700005)(8676002)(86362001)(8936002)(55016003)(66946007)(66446008)(66556008)(64756008)(66476007)(6916009)(41300700001)(54906003)(83380400001)(6506007)(7696005)(26005)(478600001)(76116006)(53546011)(9686003)(186003)(4326008)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YWsHKOM6d8R7JeWkKd4HrN00hf0D1rnSSQSuKx6S0XkWIr+zQnfATbs5gN+X?=
 =?us-ascii?Q?GP3vdz+tDHs82a4ej2Et0VoiQpZTILsabXaG9Rtf50P6V/l8AvXi869dql2e?=
 =?us-ascii?Q?Ycy6sLk/SHfjp0bTyu+uMKQSP2Qpo49rahIYHon5SXZU3adlSnvb0MTtcRUD?=
 =?us-ascii?Q?7l8Ay+vOLBFIJhXPz314T6GZEN9kpKyrx5q/a3OEVRCCWuHv4wq027Cx1C4U?=
 =?us-ascii?Q?8Sa/9sYSUNqQ5x9/LEW8fTB43j19XfROsijdyHgnq9S7XkekV7KHCGOz4k7w?=
 =?us-ascii?Q?lYvIuGYifORHTaAsBYHOZp7bMYXTzSLOlcO5Z/io3zIky+Rph5Mru/3pUrQB?=
 =?us-ascii?Q?H2WgkykXKECcHoWeRAGrPKoE2FIljQOG67c8GVBed1deks2v0On42+8To6gb?=
 =?us-ascii?Q?Qcw0lj1oOM0HcG2puFXNDdASFOFJDVUhtUv4APFssk7XwZesYPMHz9busVik?=
 =?us-ascii?Q?fn32DsR2NlaWPXWUN8u51LSkIc3j5P4nMJup65w0k7GQ75FB18i5z6gZ36AK?=
 =?us-ascii?Q?lrgZFXUBJgL4Re3gqSr4dzzsQEBAQbD7KArF0HFc3xDb0luyIoiIQbEywNwg?=
 =?us-ascii?Q?nwqSOjKNnEXvg1wfKvcJACL4/H9JwxetYWtjBT12TTQxdqoXgbNxUVIjl+Dm?=
 =?us-ascii?Q?8B2xowIQWly2vb1pg5gVKhVJklOBYlL6qsVFhZdFwnGMxFqj8+ugvekzbmGr?=
 =?us-ascii?Q?g4vGmZTUdLAwq2JGqtdNKdiXlahN3/1T0FjaG43boPwfZb91BJ6gX9U6ZA4+?=
 =?us-ascii?Q?Z9p/sHR2qVuC/5w0MnFzVzzmPciQTJnUtB1YSUCz6LFLwkkeUSQegwFrW900?=
 =?us-ascii?Q?+HwgAup+9Ro8ODWu38CYnzjxeEcSUUL9PIgfSN3H5UYg24GKY8rqNXx5XbzB?=
 =?us-ascii?Q?f1Z6XcWHH1GCwPNchUCq4QVJIt7Bfrn8wbRDGDhEozBBMiDAkk323aNAEeBf?=
 =?us-ascii?Q?ooSAjTPHJo4PpltwzlDp6+IH3gnG/3P07HqL3YEpnsoYEU5xClG7Vb2LCQVh?=
 =?us-ascii?Q?58wYaJKyorjWVT5i5C8aawve6QBmA+i5tqJg062lowYN4cCfojzZe+5+PKGn?=
 =?us-ascii?Q?zmrsmQ4QmYtuPqDs1iUauqYSUXto3IDUcNI1jztjGwJvHGbe7AjfwbULI0aK?=
 =?us-ascii?Q?0Xb780EWrwu34+fcV63Qnu9QG5mke8jaX1DD9X00sVQU+zRbSb0qr+kILvqz?=
 =?us-ascii?Q?L3jG2gZffU43ix03wulqmVCYhsIObMuX6GIFyD35EA9QSpk7ye6r9MLarDWx?=
 =?us-ascii?Q?CDeLS17f+GKb1uBGcYgmdc5L4xsrLZ/EuqrSugj4echf73E9SIwa7w+9piO+?=
 =?us-ascii?Q?oUUwgm83tLDYRcF9QAx1jGEWBtkMLYT3HPPrbXSnvLGASV/lC+e38KlnOc/D?=
 =?us-ascii?Q?yOX0MTEUYAz3RTR+0Q6yqNMNzyzcBruHd6fgqybvlT4i8zRe4tn96Xvt0I7S?=
 =?us-ascii?Q?W19n71v/tZ2MMa0aJgs5Z1NBtjS/tAa4Cwe0zYGQT798/xAYeww4YWSudyAf?=
 =?us-ascii?Q?5HJcFafDJLeMAcQt0R/yxe+HiY4NX4nngDay4SXLw0pTyVkpuQG2+dmqsCPz?=
 =?us-ascii?Q?NIMlzdV5Q1fpH9/EgZjh71x87DIqqO3WHRWq7ynJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB1883.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ceeadcc-645d-4106-4340-08db3f33ce0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 11:06:33.5641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khLrZwQLwEHESRkmQWoZXfZcWoG0JcBQQ4UjVMfSYzayzRAinjShUq0rUQ0Dzt+/P4LJBYsohwscazM0Cmo1dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4290
X-Proofpoint-GUID: uMxVVZrwarNgdbux5ccpxerdcW-niygY
X-Proofpoint-ORIG-GUID: uMxVVZrwarNgdbux5ccpxerdcW-niygY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_06,2023-04-17_01,2023-02-09_01
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
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Friday, April 14, 2023 8:05 PM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: wim@linux-watchdog.org; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-watchdog@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH 2/2] Watchdog: Add octeontx2 GTI watchdog drive=
r
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Fri, Apr 14, 2023 at 03:53:42PM +0530, Bharat Bhushan wrote:
> > GTI watchdog timer are programmed in "interrupt + del3t + reset mode"
> > and del3t traps are not enabled.
> > GTI watchdog exception flow is:
> >  - 1st timer expiration generates watchdog interrupt.
> >  - 2nd timer expiration is ignored
> >  - On 3rd timer expiration will trigger a system-wide core reset.
> >
>=20
> This means the interrupt should not result in a panic, the programmed tim=
eout
> value should be considered a pretimeout which is set to (timeout / 3), an=
d the
> interrupt handler should call watchdog_notify_pretimeout().
>=20
> Either case, the above should be documented in the driver but does not ma=
ke
> much if any sense as patch description. If not, what are the other modes,=
 and
> why is this mode used instead of any of those modes ?

Hardware supports following mode of operation:
1) Interrupt Only:
    This will generate the interrupt to arm core whenever timeout happens.

2) Interrupt + del3t (Interrupt to firmware (SCP processor)).
     This will generate interrupt to arm core whenever 1st timeout happens
     This will generate interrupt to SCP processor whenever 2nd timeout hap=
pens

3) Interrupt + Interrupt to SCP processor (called delt3t) + reboot.
     This will generate interrupt to arm core whenever 1st timeout happens
     This will generate interrupt to SCP processor whenever 2nd timeout hap=
pens, if interrupt is configured.
     This will reboot on 3rd timeout.

We are going with mode-3 above so that system can reboot in case a hardware=
 hang. Also h/w is configured not to generate SCP interrupt, so effectively=
 2nd timeout is ignored within hardware.

Software is supposed to poke within 1st timeout. If poke does not happen th=
en it will receive interrupt, interrupt handler will do panic.
But for some reason if processor can not take interrupt then system will re=
boot on 3rd timeout.

>=20
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> >  drivers/watchdog/Kconfig         |   9 ++
> >  drivers/watchdog/Makefile        |   1 +
> >  drivers/watchdog/octeontx2_wdt.c | 238
> > +++++++++++++++++++++++++++++++
> >  3 files changed, 248 insertions(+)
> >  create mode 100644 drivers/watchdog/octeontx2_wdt.c
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig index
> > f0872970daf9..31ff282c62ad 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -2212,4 +2212,13 @@ config KEEMBAY_WATCHDOG
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called keembay_wdt.
> >
> > +config OCTEONTX2_WATCHDOG
> > +	tristate "OCTEONTX2 Watchdog driver"
> > +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
> > +	help
> > +	 OCTEONTX2 GTI hardware supports watchdog timer. This watchdog
> timer are
> > +	 programmed in "interrupt + del3t + reset" mode. On first expiry it w=
ill
> > +	 generate interrupt. Second expiry (del3t) is ignored and system will=
 reset
> > +	 on final timer expiry.
> > +
>=20
> The above should be part of the in-driver documentation but those details
> should not be in Kconfig.

Ok,

>=20
> Is the documentation available in public ? I'd like to check if this mode=
, especially
> the ignored del3t mode, really makes sense.

Documentation is not public. Provided some description above, let me know i=
f I need to provide some more details.

>=20
> >  endif # WATCHDOG
> > diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> > index 9cbf6580f16c..aa1b813ad1f9 100644
> > --- a/drivers/watchdog/Makefile
> > +++ b/drivers/watchdog/Makefile
> > @@ -230,3 +230,4 @@ obj-$(CONFIG_MENZ069_WATCHDOG) +=3D
> menz69_wdt.o
> >  obj-$(CONFIG_RAVE_SP_WATCHDOG) +=3D rave-sp-wdt.o
> >  obj-$(CONFIG_STPMIC1_WATCHDOG) +=3D stpmic1_wdt.o
> >  obj-$(CONFIG_SL28CPLD_WATCHDOG) +=3D sl28cpld_wdt.o
> > +obj-$(CONFIG_OCTEONTX2_WATCHDOG) +=3D octeontx2_wdt.o
> > diff --git a/drivers/watchdog/octeontx2_wdt.c
> > b/drivers/watchdog/octeontx2_wdt.c
> > new file mode 100644
> > index 000000000000..7b78a092e83f
> > --- /dev/null
> > +++ b/drivers/watchdog/octeontx2_wdt.c
> > @@ -0,0 +1,238 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Marvell Octeontx2 Watchdog driver
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
>=20
> What is this include for ?

Taken from other driver when started coding this one. Will remove

>=20
> > +
> > +#include <asm/arch_timer.h>
> > +
> > +/* GTI CWD Watchdog Registers */
> > +#define GTI_CWD_GLOBAL_WDOG_IDX		63
> > +#define GTI_CWD_WDOG			(0x8 *
> GTI_CWD_GLOBAL_WDOG_IDX)
> > +#define GTI_CWD_WDOG_MODE_INT_DEL3T_RST	0x3
> > +#define GTI_CWD_WDOG_MODE_MASK		0x3
> > +#define GTI_CWD_WDOG_LEN_SHIFT		4
> > +#define GTI_CWD_WDOG_CNT_SHIFT		20
> > +
> > +/* GTI Per-core Watchdog Interrupt Register */
> > +#define GTI_CWD_INT			0x200
> > +#define GTI_CWD_INT_PENDING_STATUS	(1ULL <<
> GTI_CWD_GLOBAL_WDOG_IDX)
> > +
> > +/* GTI Per-core Watchdog Interrupt Enable Clear Register */
> > +#define GTI_CWD_INT_ENA_CLR		0x210
> > +#define GTI_CWD_INT_ENA_CLR_VAL		(1ULL <<
> GTI_CWD_GLOBAL_WDOG_IDX)
> > +
> > +/* GTI Per-core Watchdog Interrupt Enable Set Register */
> > +#define GTI_CWD_INT_ENA_SET		0x218
> > +#define GTI_CWD_INT_ENA_SET_VAL		(1ULL <<
> GTI_CWD_GLOBAL_WDOG_IDX)
> > +
> > +/* GTI Per-core Watchdog Poke Registers */
> > +#define GTI_CWD_POKE		(0x10000 + 0x8 *
> GTI_CWD_GLOBAL_WDOG_IDX)
> > +#define GTI_CWD_POKE_VAL	(1ULL << GTI_CWD_GLOBAL_WDOG_IDX)
> > +
> > +struct octeontx2_wdt_priv {
> > +	struct watchdog_device wdev;
> > +	void __iomem *base;
> > +	u64 clock_freq;
> > +	int irq;
> > +};
> > +
> > +static irqreturn_t octeontx2_wdt_interrupt(int irq, void *data) {
> > +	panic("Kernel Watchdog");
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int octeontx2_wdt_ping(struct watchdog_device *wdev) {
> > +	struct octeontx2_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +
> > +	writeq(GTI_CWD_POKE_VAL, priv->base + GTI_CWD_POKE);
> > +	return 0;
> > +}
> > +
> > +static int octeontx2_wdt_start(struct watchdog_device *wdev) {
> > +	struct octeontx2_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +	u64 regval;
> > +
> > +	set_bit(WDOG_HW_RUNNING, &wdev->status);
> > +
> > +	/* Clear any pending interrupt */
> > +	writeq(GTI_CWD_INT_PENDING_STATUS, priv->base + GTI_CWD_INT);
> > +
> > +	/* Enable Interrupt */
> > +	writeq(GTI_CWD_INT_ENA_SET_VAL, priv->base +
> GTI_CWD_INT_ENA_SET);
> > +
> > +	/* Set (Interrupt + SCP interrupt (DEL3T) + core domain reset) Mode *=
/
> > +	regval =3D readq(priv->base + GTI_CWD_WDOG);
> > +	regval |=3D GTI_CWD_WDOG_MODE_INT_DEL3T_RST;
> > +	writeq(regval, priv->base + GTI_CWD_WDOG);
> > +
> > +	return 0;
> > +}
> > +
> > +static int octeontx2_wdt_stop(struct watchdog_device *wdev) {
> > +	struct octeontx2_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +	u64 regval;
> > +
> > +	/* Disable Interrupt */
> > +	writeq(GTI_CWD_INT_ENA_CLR_VAL, priv->base +
> GTI_CWD_INT_ENA_CLR);
> > +
> > +	/* Set GTI_CWD_WDOG.Mode =3D 0 to stop the timer */
> > +	regval =3D readq(priv->base + GTI_CWD_WDOG);
> > +	regval &=3D ~GTI_CWD_WDOG_MODE_MASK;
> > +	writeq(regval, priv->base + GTI_CWD_WDOG);
> > +
> > +	return 0;
> > +}
> > +
> > +static int octeontx2_wdt_settimeout(struct watchdog_device *wdev,
> > +					unsigned int timeout)
> > +{
> > +	struct octeontx2_wdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +	u64 timeout_wdog, regval;
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
>=20
> This should be covered when setting max_timeout or max_hw_heartbeat_ms.
> Setting the actual timeout to a value smaller than configured may result =
in the
> watchdog firing before its configured timeout expires.

wdog_dev->max_timeout =3D 16 is set based on above description, will move t=
his comment there.

Just to explain why I added above comment here and below check, that was to=
 ensure that if user provides timeout more than " wdog_dev->max_timeout" th=
en program wdog_dev->max_timeout only.
But now looking at the code "set_timeout()" will be called only if timeout =
is valid ( timeout is <=3D wdog_dev->max_timeout)

So above comment is not valid, while below check can also be removed.

>=20
> > +	 */
> > +	timeout_wdog =3D (timeout_wdog + 0xff) >> 8;
> > +	if (timeout_wdog >=3D 0x10000)
> > +		timeout_wdog =3D 0xffff;
> > +
> > +	/*
> > +	 * GTI_CWD_WDOG.LEN have only upper 16-bits of 24-bits
> > +	 * GTI_CWD_WDOG.CNT, need addition shift of 8.
> > +	 */
> > +	regval =3D readq(priv->base + GTI_CWD_WDOG);
> > +	regval &=3D GTI_CWD_WDOG_MODE_MASK;
> > +	regval |=3D ((timeout_wdog) << (GTI_CWD_WDOG_CNT_SHIFT + 8)) |
> > +		   (timeout_wdog << GTI_CWD_WDOG_LEN_SHIFT);
>=20
> () around timeout is unnecessary. Why does the timeout need to be program=
med
> twice into the register ? The shift values are odd.
> Are you sure this does what you expect it to do ?

This register have two timeouts:
   GTI_CWD_WDOG.CNT[43:20] (24bit) =3D this is something decrementing with =
a frequency.
   GTI_CWD_WDOG.LEN[19:4] (16bit) =3D this is something loaded in upper 16 =
bits of GTI_CWD_WDOG.CNT when poke happens.

Shift looks odd but it works as expected.

>=20
> > +	writeq(regval, priv->base + GTI_CWD_WDOG);
> > +	return 0;
> > +}
> > +
> > +static const struct watchdog_info octeontx2_wdt_ident =3D {
> > +	.identity =3D "OcteonTX2 watchdog",
> > +	.options	=3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> WDIOF_MAGICCLOSE |
> > +			  WDIOF_CARDRESET,
> > +};
> > +
> > +static const struct watchdog_ops octeontx2_wdt_ops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.start =3D octeontx2_wdt_start,
> > +	.stop =3D octeontx2_wdt_stop,
> > +	.ping =3D octeontx2_wdt_ping,
> > +	.set_timeout =3D octeontx2_wdt_settimeout, };
> > +
> > +static int octeontx2_wdt_probe(struct platform_device *pdev) {
> > +	struct octeontx2_wdt_priv *priv;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct watchdog_device *wdog_dev;
> > +	int irq;
> > +	int err;
> > +
> > +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base))
> > +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->base),
> > +			      "reg property not valid/found\n");
> > +
> > +	priv->clock_freq =3D arch_timer_get_cntfrq();
> > +
> > +	wdog_dev =3D &priv->wdev;
> > +	wdog_dev->info =3D &octeontx2_wdt_ident,
> > +	wdog_dev->ops =3D &octeontx2_wdt_ops,
> > +	wdog_dev->parent =3D dev;
> > +	wdog_dev->min_timeout =3D 1;
> > +	wdog_dev->max_timeout =3D 16;
>=20
> Setting max_timeout makes max_hw_heartbeat_ms useless. Use only
> max_hw_heartbeat_ms to enable larger soft timeouts, or use only max_timeo=
ut
> to set the hard limit, but not both.

Okay, thanks for details

>=20
> > +	wdog_dev->max_hw_heartbeat_ms =3D 16000;
> > +	wdog_dev->timeout =3D 8;
> > +
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "IRQ resource not found\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	err =3D request_irq(irq, octeontx2_wdt_interrupt, 0, pdev->name, priv=
);
> > +	if (err) {
> > +		dev_err(dev, "cannot register interrupt handler %d\n", err);
> > +		return err;
> > +	}
>=20
> Use devm_request_irq() and request the interrupt after registering the wa=
tchdog.

Okay,

>=20
> > +
> > +	priv->irq =3D irq;
> > +	watchdog_set_drvdata(wdog_dev, priv);
> > +	platform_set_drvdata(pdev, priv);
> > +	watchdog_init_timeout(wdog_dev, wdog_dev->timeout, dev);
>=20
> watchdog_init_timeout sets wdog_dev->timeout, so this is pointless.
> Calling watchdog_init_timeout() only makes sense if the parameter is eith=
er a
> timeout module parameter or 0 and the idea is to use a value from devicet=
ree if
> configured.

Okay, thanks again for detail

Regards
-Bharat

>=20
> > +	octeontx2_wdt_settimeout(wdog_dev, wdog_dev->timeout);
> > +	watchdog_stop_on_reboot(wdog_dev);
> > +	watchdog_stop_on_unregister(wdog_dev);
> > +
> > +	err =3D devm_watchdog_register_device(dev, wdog_dev);
> > +	if (err) {
> > +		free_irq(irq, priv);
> > +		return err;
> > +	}
> > +
> > +	dev_info(dev, "Watchdog enabled (timeout=3D%d sec)\n", wdog_dev-
> >timeout);
> > +	return 0;
> > +}
> > +
> > +static int octeontx2_wdt_remove(struct platform_device *pdev) {
> > +	struct octeontx2_wdt_priv *priv =3D platform_get_drvdata(pdev);
> > +
> > +	if (priv->irq)
> > +		free_irq(priv->irq, priv);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id octeontx2_wdt_of_match[] =3D {
> > +	{ .compatible =3D "marvell-octeontx2-wdt", },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, octeontx2_wdt_of_match);
> > +
> > +static struct platform_driver octeontx2_wdt_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "octeontx2-wdt",
> > +		.of_match_table =3D octeontx2_wdt_of_match,
> > +	},
> > +	.probe =3D octeontx2_wdt_probe,
> > +	.remove =3D octeontx2_wdt_remove,
> > +};
> > +module_platform_driver(octeontx2_wdt_driver);
> > +
> > +MODULE_AUTHOR("Bharat Bhushan <bbhushan2@marvell.com>");
> > +MODULE_DESCRIPTION("OcteonTX2 watchdog driver");
> > --
> > 2.17.1
> >
