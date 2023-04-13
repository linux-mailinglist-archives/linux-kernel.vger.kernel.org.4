Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5386E0B51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjDMKUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMKUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:20:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5AAEB;
        Thu, 13 Apr 2023 03:20:37 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D8TpdJ025767;
        Thu, 13 Apr 2023 03:20:16 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3px6byu6m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 03:20:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+R+k/BE3dZdCDoewnce11vxyld/wQAdzIyYMB5mk1Fw2rH42IvelSb310aGmLpYYBecDQ10ymCKUTTs4QZH0pj+KC9EvZ63QkuQ+VI/HJtqmQmOlHH47rJALZkDtsTEgpN9XZTYtPUFya6F/WkEhI5QilwFPRkUr26te4lyr2ojjpIM9xgW1AnvSHzlbti2L5KJwZdh9z2/Hwk+Aygp6zFv9yonoLB/oOQXBCHROHrBWQYb5lKzdvt+GxxWvIzlmyUDPlk8K8sDcGpQ3Fv1dfIl7gNFjX97kUSJffO30IFbj2le0/Co0DcPcIbtzNXjzvuYKH4sDruOQlXprLZPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03kWB9kbirLT2B87jkKSDpLinpx7cbE5ljdHI1JEd6E=;
 b=fkVLIvNJo55adWimtrZL26pA3N8laERlhCqQ53ij4lP2MSedZrEovrw8zDdJVcyOsnmvIsGtKjvibG+FM2K7eTZ1lTXgx090mD7lNtR/G790DjC4aQ/OnUcUi8ncmHeLN4JMw/xMvMKlQcgiaYf3LvG6o5q4taF0VQofB2ZPdT+Vj3vaL9qwoUVnpJE+j4xJ+N82ZJn6lm5bSZerQN7fYze/jRQkIwcQEz8OgpHj8ZRBvS5ZnvtSODXo0RpnKHRHtjzqq8e+gzYXRwpgT+R8tbGGAV5DtZehBqoorMX1cDj3Vz/dRf6skM8NDHAzF6DVwG7Zx9bcUvLRTUFXkYODJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03kWB9kbirLT2B87jkKSDpLinpx7cbE5ljdHI1JEd6E=;
 b=PQ28/hpUkhS/6mczUNq0MnGjWUSBvGEN7+YTk9XdNjmaCohdyv5+035mHxSM5h19O139JkOkdHXDcqwUj+QAm5Tx2v6CGFt8bggixecoU6StAGefVFF07qlf6VP/MQh+CjcdFsyzgIqUfPG9Kpmo79dVXXquS1HhXaEPU0f57DY=
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com (2603:10b6:4:62::23)
 by BYAPR18MB2966.namprd18.prod.outlook.com (2603:10b6:a03:10d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Thu, 13 Apr
 2023 10:20:10 +0000
Received: from DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::539a:cb03:47cd:9551]) by DM5PR1801MB1883.namprd18.prod.outlook.com
 ([fe80::539a:cb03:47cd:9551%5]) with mapi id 15.20.6254.033; Thu, 13 Apr 2023
 10:20:10 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <thomas@t-8ch.de>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
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
Thread-Index: AQHZXmDnieHT6oIyl0uEPZQVd86ruq8Ka8QAgB645qA=
Date:   Thu, 13 Apr 2023 10:20:10 +0000
Message-ID: <DM5PR1801MB188372030FAD6363AB0FCE2CE3989@DM5PR1801MB1883.namprd18.prod.outlook.com>
References: <20230324145652.19221-1-bbhushan2@marvell.com>
 <20230324145652.19221-2-bbhushan2@marvell.com>
 <6ede1391-7b60-4c78-a93b-40d2c96e6ae8@t-8ch.de>
In-Reply-To: <6ede1391-7b60-4c78-a93b-40d2c96e6ae8@t-8ch.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYmJodXNoYW?=
 =?iso-8859-1?Q?4yXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02?=
 =?iso-8859-1?Q?Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYzFjM2Y3NjQtZDllNC0xMWVkLWFlNz?=
 =?iso-8859-1?Q?ktMDRiOWUzMzM4ZjZlXGFtZS10ZXN0XGMxYzNmNzY2LWQ5ZTQtMTFlZC1h?=
 =?iso-8859-1?Q?ZTc5LTA0YjllMzMzOGY2ZWJvZHkudHh0IiBzej0iMTQ4NjkiIHQ9IjEzMz?=
 =?iso-8859-1?Q?I1ODU0ODA1NTM3MjgwOCIgaD0id09DbkpsaTdGOE5zRHdJODJhZDhuMko5?=
 =?iso-8859-1?Q?RDM4PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUl?=
 =?iso-8859-1?Q?VGTkNnVUFBSFlJQUFBSTlCK0U4VzNaQVVrd3FnTVVxM21YU1RDcUF4U3Jl?=
 =?iso-8859-1?Q?WmNOQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBQUdDQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUVBQVFBQkFBQUExRkgzYUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFKNEFBQUJoQUdRQVpBQnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbm?=
 =?iso-8859-1?Q?dBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY0FCbEFISUFjd0J2QUc0QUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWXdC?=
 =?iso-8859-1?Q?MUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0IxQUcwQVlnQmxBSE?=
 =?iso-8859-1?Q?lBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVBY3dCME?=
 =?iso-8859-1?Q?FHOEFiUUJmQUhNQWN3QnVBRjhBWkFCaEFITUFhQUJmQUhZQU1BQXlBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQU?=
 =?iso-8859-1?Q?FuZ0FBQUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFC?=
 =?iso-8859-1?Q?M0FHOEFjZ0JrQUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZ?=
 =?iso-8859-1?Q?d0IxQUhNQWRBQnZBRzBBWHdCekFITUFiZ0JmQUc0QWJ3QmtBR1VBYkFCcE?=
 =?iso-8859-1?Q?FHMEFhUUIwQUdVQWNnQmZBSFlBTUFBeUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCakFIVUFjd0?=
 =?iso-8859-1?Q?IwQUc4QWJRQmZBSE1BY3dCdUFGOEFjd0J3QUdFQVl3QmxBRjhBZGdBd0FE?=
 =?iso-8859-1?Q?SUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1FBYkFCd0FGOEFjd0Jy?=
 =?iso-8859-1?Q?QUhrQWNBQmxBRjhBWXdCb0FHRUFkQUJmQUcwQVpRQnpBSE1BWVFCbkFHVU?=
 =?iso-8859-1?Q?FYd0IyQURBQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFR?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpBQnNBSEFBWHdCekFHd0FZUUJqQU?=
 =?iso-8859-1?Q?dzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJrQUd3QW?=
 =?iso-8859-1?Q?NBQmZBSFFBWlFCaEFHMEFjd0JmQUc4QWJnQmxBR1FBY2dCcEFIWUFaUUJm?=
 =?iso-8859-1?Q?QUdZQWFRQnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHVUFiUUJoQUdrQWJB?=
 =?iso-8859-1?Q?QmZBR0VBWkFCa0FISUFaUUJ6QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFDd0FBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQm?=
 =?iso-8859-1?Q?ZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QmpBRzhBWkFCbEFITUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWRBQmxB?=
 =?iso-8859-1?Q?SElBYlFCcEFHNEFkUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdB?=
 =?iso-8859-1?Q?QUFBQUEiLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR1801MB1883:EE_|BYAPR18MB2966:EE_
x-ms-office365-filtering-correlation-id: 4e0117fe-9eaf-4747-36ca-08db3c08a98f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27VI2sKV5OhZnd7Wl8XUuX8uuEeuln88dKqLxzkfWa0SljUz/Y6w7npivZQopKDkGJin6l/J9BU3igvSlMh4cV1FMwL/TjukNMLjm7I83H85KMhGwPhRjlet9mXgbt7UvoSV/lMVnWvBsPa/YqrhHxmj5/aXHBbisFsVqDEH2Gi+uccLyVjrGyy/114qg5k266O1C8ccvMm6L1ZBY5AUaEojJAIXweBZGkcPUzlM1lyjRH70JjUXQIwp/XjpMwBWV3EILhCEsL++vzEJ2kMQ9fYlDN0S4bdPuVChyqjEXkLGoUdDoqG/TRp727FBRBm0tPEwvHI6tHc6jZ1JGFs1WuQ9KPZWL0l4CZ9c3Xn6iH/CT1fUmkxLlnBmlkIxNO7/M7XGqBK7by8UpSohh0FvHRLhPESSYo9xh2bQDRA2mkw+UbSFOyq2up1eEPrfhsLeCirV8e6v0CKrr8EFTnKF9QgAUYI/OIj1Xaw3AIj2aFxJqQbW67zQCx/ExiyMDMgS7up7lF7aIDnnLx0qgbBvJcODOSIBNos33h+O/5brjR3bL3Jx9B3EV3TU+9dvnLGQmo5R8AywKw2OJ/m8DhqcEi0ZPlblaBDyHWvNgYbRYc0OZqlrGgqovcHWss0AseV6ui6njLAeAsn1OBbJqaT3xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1801MB1883.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199021)(55016003)(8676002)(66574015)(64756008)(83380400001)(71200400001)(6506007)(55236004)(316002)(186003)(26005)(54906003)(478600001)(9686003)(53546011)(7696005)(5660300002)(52536014)(30864003)(2906002)(4326008)(33656002)(38100700002)(76116006)(8936002)(122000001)(6916009)(66556008)(66476007)(66446008)(86362001)(66946007)(38070700005)(41300700001)(2004002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c/38kDwRYJVGc/Ph8JaGcMUnsawJ6gN35ElhLa9slSf5n4Jslz2lZFb36d?=
 =?iso-8859-1?Q?x6C/1m7kFwvkvpJCjgsvF+DEzuQlOXNrgWYlUssSMa672gcWAYemoGJTch?=
 =?iso-8859-1?Q?fPT/K3Ml0bzQboD48vhzTNYMBJkpgl/i/x7DeQmMz1dLM6SzP1XTe0O8AX?=
 =?iso-8859-1?Q?ZfF4rx4b3xbdJe8tr8zSKkdFIDmfhz88z3ktrXwXVwBDMCDOSuqgFfJ7vq?=
 =?iso-8859-1?Q?i1PU+ysre9sjAPkK9ublwVcCnx+A9s4B8bbc0PfZ39K+9NGuCRVVVqOW7u?=
 =?iso-8859-1?Q?Z0Y9sBYLHe2lF9Dyg9PBMEK2bmN0ZeOC/wPZwAH/t+t2TtjNNnuV7CnR6T?=
 =?iso-8859-1?Q?OUxs0Ev0a/1Ek2lLmMICKxM5AUaFNUDc9qQjX+DRFxhxSRrBTxv4k2UnkL?=
 =?iso-8859-1?Q?6agBZFUu/CslTEAEx86c5VRwR8aklABBmBTVpJMuVghaeEkJkqDYzFZ6e4?=
 =?iso-8859-1?Q?Eo8ADmSNEkjszy9DIvqoJd3ofmhzhuI75RfhetMMOhIwqOrxdNBvcYSSpl?=
 =?iso-8859-1?Q?iK3Ox23SNpfAZm8I1RtF6cz5lfdA/DfX2tn8XnbfoNYvN51MEot3CR1uLS?=
 =?iso-8859-1?Q?DnJfwjmc+1Gz/FHLzP1QJwOkPyIFHxHceinlD0euXb401bzaN7lZjeZfrT?=
 =?iso-8859-1?Q?BXzQVi2geTd+NtHh9vVcTVFvsTvdb3xs/AEPOtydBLHQ8Hj0kZ6eGf+Jcw?=
 =?iso-8859-1?Q?Kl4whhn1SXOAX8EV2HRQBe8KbaeAqGMNAIfzuw11CVqzLsBSTZippD4dQd?=
 =?iso-8859-1?Q?Q1RXjAI5bEFgQVSV8apgO7vRmPR6SzQdn4H5UJdLi1UwzOLipvv8/3Hs7l?=
 =?iso-8859-1?Q?eW+rgG2Uq/9iARULkISUUC7AJfirW+KXG7TOx1z96NUxapOcRI1SOsHVK4?=
 =?iso-8859-1?Q?79C/h5Is2ENu8tOZ9vERKYg9GSrBH+TlNjeOVYcQCPuaTMU5zRHq3izKmZ?=
 =?iso-8859-1?Q?SO03OQUMkkQsz7y1MPXiOfxdsTwfxgfH9+A7fZl1nC16QN1KrT+NwqqYm6?=
 =?iso-8859-1?Q?t8rBZesH2YMgKVO4QFcZbImDXL/4C6j1Y9c/gw4KCAvXML51vxdVyR7EBX?=
 =?iso-8859-1?Q?3+VxF/QfRUm0lP9EYuSpI0LegPokg+JwfYzsAoIc1LVDTN6b+kjVaO/NHY?=
 =?iso-8859-1?Q?K8Ojnyu3WcoicOdCFlKd4Re1xuKuRaj+xcLRikqlFfCRyrqF5VlY7lbeQL?=
 =?iso-8859-1?Q?wOWuiJl8dvgzN12TgGcoGwkRwNvI5ZldAYMGvyatjl2b0eh7AVQf48QYZK?=
 =?iso-8859-1?Q?dwVHwqjpZjfKe6WJS1ZbnR0eDWvF4NoVNzxSbPRecEuRv/KDkuqPuyCk+5?=
 =?iso-8859-1?Q?a7xeaXPPVEXwDtJoKh3LLLoSjKYbI4znGDQHoFiZcHwA8VhDh8VwfVk3ZB?=
 =?iso-8859-1?Q?YzXhTW2ZpZ0KXfMF1JEfmcnSk+yAtVXdQelzlkGk5qwx4E13NXS5qsbCJ9?=
 =?iso-8859-1?Q?T8VAFtceZ1QBEFfbwsZVIhYJJ/3N9oggqDClxwy1zOMW0092+QUfr5K2rc?=
 =?iso-8859-1?Q?fLJauWMe5aLJQIYEfdtuQwAaNfnfERI2iuwqbwiOqHo12r5l8okVhEYzSG?=
 =?iso-8859-1?Q?/x/gdaURhYb5I7UPp8HyGsIYXWjgvYT1P7ltxZsPYWCI0HZqmLLIBrMrqz?=
 =?iso-8859-1?Q?0ylXOngXVuwHPpckeVafR4CxTScFlPXCpO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1801MB1883.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0117fe-9eaf-4747-36ca-08db3c08a98f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2023 10:20:10.4543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPfMMkpk9XcEGKu9Vx3TaOZB3uFqi/JQ2De5ptkB03ITLyzeoYtpumGXgF533tsEKhfzo2RXWzzCh2L7uiVjDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2966
X-Proofpoint-GUID: Efi3CnIumxGf1O1yd2cZVhDvdp-_GemR
X-Proofpoint-ORIG-GUID: Efi3CnIumxGf1O1yd2cZVhDvdp-_GemR
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
> From: Thomas Wei=DFschuh <thomas@t-8ch.de>
> Sent: Saturday, March 25, 2023 2:35 AM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: wim@linux-watchdog.org; linux@roeck-us.net; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linux-watchdog@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH 2/2] Watchdog: octeontx2: Add Pseudo-NMI GTI
> watchdog driver
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On 2023-03-24 20:26:52+0530, Bharat Bhushan wrote:
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
> > +void octeontx2_gti_wdt_callback_other_cpus(void *unused)
>=20
> Could be static.

First, sorry for late reply, just came back from vacation.

Will fix,

>=20
> > +{
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
>=20
> Weird alignment.

Do not know why it is showing like this, in code it looks good.

>=20
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
>=20
> This unlikely() should really not be needed.

Will remove.

>=20
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
>=20
> No trailing comma for end-of-array marker.

Will fix.

Thanks
-Bharat

>=20
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
>=20
> No MODULE_LICENSE() ?
