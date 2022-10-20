Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E05606381
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiJTOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiJTOsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:48:03 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CB517E220;
        Thu, 20 Oct 2022 07:47:59 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29KEMjNU006472;
        Thu, 20 Oct 2022 10:47:27 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3k7pq7tha4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 10:47:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrjiOOLVoaI1UuCFSCPeVYHHE0qT7BDilE18kxVQ4lJcLdrEYY+7c6jC52TbJmCs9r6mJ30JJRFID2e68TBwg8TmoaTPwSu9h8L3Jz8rRo+1zNWsDWoL2/LCIy3ppVvCQyIwgBZXOmifCJhorJKckSwAnwVEenE0E0YcQqqn/Lv36n9v7zn68JMxvfcv9hoNTfYm14bVuJcC/OspMzXB/dOW8HL6/ExHLwan+qNJWSo0SdHvTczwmoqD1sStp7YLBdLlW1pdFCbDPqOkKu024K5ehRVM21VyW3Rwm92eiQeiyIRMsmGM1GKgJkZgyVBwDA4/cvBFYLbaKfW/A7C9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpMmdtk9BKTcvkTqKOcdN7efdWNMYQOdUnlxHRHn62c=;
 b=ULsi+LmBi1pKZjrde1zxm3HojpIwcMYrwHuOoL6S7QbL1MB+2QzOw3HxemzKAIQS79ywk9m/DqHODwhonGTM7xETt9sh6YJpLXPMNZquG4SQ1mTf5C8KFYrvs4oLFsXhjtG5U7l5pewY/eJQHpiEIJ+cYVliVuaZxa9XXJ6tRtknYIpz9q90QW7ulAUqa0HK3fjErsQly8F6p+xi/7+i9UZlEg3zcfytyFN+tabZyed8gRzsnWGXsvzDayOFdwuEgaiYmX5JHv90JXmzKYbxkx66FZ9lC55AMktd60MNefCPiRPwThha9ciVHArJJe3CnX+WE9H7H43BJZoZEe0y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpMmdtk9BKTcvkTqKOcdN7efdWNMYQOdUnlxHRHn62c=;
 b=ZkGTJKyAOUDIu4YPfEjsCjaQkwjrpM0E3pwTjQeuhom0e5/KDb0jZQWfmkN5INKK7HYUix58crJO5pma0rN1JMmOqpZSp0jzOHqWLiAZDSV6aLi3Zb44MSChlxAG0Ke9SPD45hJvrA+sFNuAKhSl3p8/c1g5s0Z4nZVAa2X5hBk=
Received: from DM8PR03MB6247.namprd03.prod.outlook.com (2603:10b6:8:3b::6) by
 SJ0PR03MB5629.namprd03.prod.outlook.com (2603:10b6:a03:278::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 14:47:25 +0000
Received: from DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::17cf:8070:5f0f:8b37]) by DM8PR03MB6247.namprd03.prod.outlook.com
 ([fe80::17cf:8070:5f0f:8b37%7]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 14:47:25 +0000
From:   "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Subject: RE: [PATCH 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Topic: [PATCH 1/2] drivers: rtc: add max313xx series rtc driver
Thread-Index: AQHY48BV4C7K0rjzoke7fwYndwALEK4V17iAgAGFAYA=
Date:   Thu, 20 Oct 2022 14:47:25 +0000
Message-ID: <DM8PR03MB624786DEF5E135986ECB7B1F962A9@DM8PR03MB6247.namprd03.prod.outlook.com>
References: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
 <409d7e93-f911-11b6-ed54-8ae8c94a8af0@roeck-us.net>
In-Reply-To: <409d7e93-f911-11b6-ed54-8ae8c94a8af0@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYVdKeVlXaHBiUzUwYVd4cmFWeGhjSEJrWVhSaFhISnZZVzFwYm1kY01E?=
 =?utf-8?B?bGtPRFE1WWpZdE16SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpW?=
 =?utf-8?B?aVhHMXpaM05jYlhObkxURTVabVF3T0RKaUxUVXdPRFl0TVRGbFpDMDRaVFl6?=
 =?utf-8?B?TFRkallqSTNaRGN5TXpGaFlseGhiV1V0ZEdWemRGd3hPV1prTURneVpDMDFN?=
 =?utf-8?B?RGcyTFRFeFpXUXRPR1UyTXkwM1kySXlOMlEzTWpNeFlXSmliMlI1TG5SNGRD?=
 =?utf-8?B?SWdjM285SWpVMU55SWdkRDBpTVRNek1UQTNOVEE0TkRJd05EZzNPVFV5SWlC?=
 =?utf-8?B?b1BTSktaQ3RKWmpkbldUbEtVbTkyYWpod05UTlZNR2htTURCd2NFVTlJaUJw?=
 =?utf-8?B?WkQwaUlpQmliRDBpTUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhV?=
 =?utf-8?B?bE5TVlVaT1EyZFZRVUZGYjBOQlFVRlJTekZtWTJ0MVZGbEJXVzVRTVdaclRE?=
 =?utf-8?B?Vk5SQ3RwWXk5V0sxRjJhM2RRTkVSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCU0VGQlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJSVUZCVVVGQ1FVRkJRVmcxYkRKTGQwRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVvMFFVRkJRbWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFt?=
 =?utf-8?B?eEJSamhCWTBGQ2VVRkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVG?=
 =?utf-8?B?SGQwRmpkMEpzUVVZNFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRV2RCUVVGQlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZI?=
 =?utf-8?B?VFVGa1VVSjVRVWRWUVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5R?=
 =?utf-8?B?VmgzUWpCQlIydEJXbEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCVVVGQlFVRkJRVUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFW?=
 =?utf-8?B?aDNRbnBCUjFWQldYZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xG?=
 =?utf-8?B?Q2FrRklVVUZqZDBKbVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgr?=
 =?utf-8?B?UEM5dFpYUmhQZz09?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR03MB6247:EE_|SJ0PR03MB5629:EE_
x-ms-office365-filtering-correlation-id: 4a26a558-e3bc-454c-83de-08dab2aa00b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6e7SzqgIwVKq6Y41XHB3CJHyYOeG7OaixVuiuey1HbfkgR0iedofz2H0lomh8KCWozLrf3FxnzgQFXAzEo1X9iwGCc728ly4hMuxnBYna3dgre0KxoU1SpjUfFJwWz7J2BiC4z9f9x5hDK6NKIaX2LMjzZtTE9UYwoEOYZ1Xs7RWQ7v9y42n2axq8RLq4MK3Z0+Q3wOE3syKBFOTNFObeUnjs3P+WordJZfVbfUgTQ+Q545pmjv4OORTQ8BnhuyLmcCuQIV/iqRorI6NGlj6WGXf9P1oThsyn/5IxBA9+ZKx02V0NdcRMthrMf9cEuobUUUfTrHfpnhmofcTxwv40qaqavtqER0a7USID83psNaZondYJzlhkgfo3oSXGXbGloS1Z4XQgoux24efsfpV3FK/X9fiQ5cvVBKI9YXi1ZDt/TG2D06QxsFFfxl0fp9OL95nA72BwcnIPhoO+m6BY6ywBi36tIn2yMwJSR08lEYqxfHOvu5o+yQhWf8uTiancUzZHjTEq4ru8FkxFjlI8Zt9v/7aq14yCOsIU54rynDldeLp4PZlxgzryNUxb4yhp3UHBhtK/pFZWS3IlzMJJMoyE0vsC2YDkvQ8p88chclPRhGacf6q5fFCWnzNsb5fe6JcDyhbm5J7Gym+25CadvS4JrziK0C9OJmzYUGTyWcIc0jr6E0oGSML8HHYag0WFVEuxqj6RMeHKfTwNZ1lkxMcYhbJIX0FDWhOKAmsFj6P4BLw01GYG+oH1mV9ce8LYWNYSDvKVbxpyjpsEvP5qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6247.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199015)(38100700002)(122000001)(38070700005)(55016003)(86362001)(107886003)(4744005)(33656002)(2906002)(71200400001)(66556008)(478600001)(66446008)(316002)(110136005)(4326008)(8676002)(64756008)(41300700001)(66946007)(8936002)(76116006)(52536014)(7416002)(66476007)(54906003)(5660300002)(83380400001)(9686003)(26005)(7696005)(6506007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qjd1a0F2dnZ4Q3krSmtScVBidkxLMUxHZVFFMjZJL3dIL2o0dW0xOVhMWUEx?=
 =?utf-8?B?Nk9Fc3cyMVJZa0h2WDFCUmdFckVPMGZFQVRxM2ErZ1VsS1pkM1FiWnRaVE5L?=
 =?utf-8?B?MXNvUlFSd2E4clpqZVF6SzFiRW1sRERIZmZJOXljUTdOa3lKdVBBKy9Nd0Fj?=
 =?utf-8?B?WHVyQ21VNUFSUVlmNmVpOGVnOGUxNTB3TXd2dHZMR3ZpSTQra00xeGViZFR6?=
 =?utf-8?B?UjMvNHo1VHlYWHAwUHVleXBJajFSL2R4UDVWLzd2akRtcnZldHZRVnhHRjdt?=
 =?utf-8?B?emdMeHE2NWE3VzdHbkJSZHZLVTlXVGNITWFhckxMQStSZ3pRYlpPTlpMNDhC?=
 =?utf-8?B?K08rTUJzcFkxWnMvWlc3Z2owZnVmRnVMckVMZURNSVJ4WWhjYUdRUjhtNTBC?=
 =?utf-8?B?ZHJUWmJJc1ozV0w4aDc3OURtVjJRYlhScG81QUhhRlUxRTJDeVJHbkczcWMz?=
 =?utf-8?B?Y3pETzV4cDladm95ZmNldFdLbWowV2NScDl4Qk9jZ0dxVlVkL2pLK1JXRmts?=
 =?utf-8?B?N01nRjUvUVdFaUU3ai83cjRtN3J4eTFkc3NXSUZrZkh6V29uYTBTclJVL3lv?=
 =?utf-8?B?WmhLZFovOVdzSEFod29oVnhscDRQZURZVEJRL1NYVFh0c05WZ25aZVNWRDQ1?=
 =?utf-8?B?TXEveDMvZDVrOHlrSFNzN1VUVy9Tcy9BeVFDRUQxMW1vNlV2NjBuRTRKUCtl?=
 =?utf-8?B?L0F6Mk8rT09oVDRubWVNd1VyUkdjVjVadElkeGNoVDAwQTFJR0NoZlEvdHlC?=
 =?utf-8?B?V3dEQVpQVGtyQVdhOXRQZlZaREJGWm8yVkNyclllem1YQVFWZFA4bDBuUTd4?=
 =?utf-8?B?UFhFK0xqNWFIZVZSMHpNTEJVSGtBNFJBTzMzcDMwcmNYckxtNzJhZkNYMGc5?=
 =?utf-8?B?MWtXRHhjRTk0Q0NLWGIxTmlaNERtVTZxMmxOZUNMWURPWGZ4MXF3YTE5KzFO?=
 =?utf-8?B?aEdqcHl0MWdiZk5zQnNHUVoxU2VOQnlBcS9jNGRSa0x1Tm9xdEltREpPYWF4?=
 =?utf-8?B?dzd4RzJ3LzNCWEdqcmdPVFNML3ljWUVoZ2J4RE9LaDJidEFHREJHTllkaStX?=
 =?utf-8?B?bldMemJQeGcrYjBBREJjK1hrSjVXMGE4Nmt6S3RIT0sxQUZPUmRRMm05REpJ?=
 =?utf-8?B?RlIzT2wweUNqeWM4WGZQdUV2UGg4U2laKzhIM1A2M21udXgrTlB5OGtXSjgv?=
 =?utf-8?B?ZDlrNi94QmQwTFZwN3c4OHd3cHFaRFNhbGorU3AzaVI4M29iMEpjN1lueE8r?=
 =?utf-8?B?MDlKcWJEU1hVYXVCS3JiZ084Ky9tSlVkYjJvK0NiZkhVZng4TWFYeFdKQzFZ?=
 =?utf-8?B?WkkyVUpVMnVvNndFQzhtdlFsZitkMkFRU3BUS3VBVXkwc2k3OGNZaXpyQjht?=
 =?utf-8?B?UXh5cjR4RVovZmhBNThxV2E4QXc2TE05eFlBa2lQZkh5RFZnNEV1Y25RRHZZ?=
 =?utf-8?B?QkRIS3RrN3oyclpBRXRkSXMvQXNRZHpBWFhtRDlRN3REd21WQVRTQi83a2p2?=
 =?utf-8?B?ZWQrNXlHY3NQc2xaRkZLRE91TWk5blorYjNIS2JGU3B5R21HdEhQUjd1RDN5?=
 =?utf-8?B?dHRTL2UrYUlLejBxWEIzMU00TWJ4V2ljdjBmVXVZb3g0Y1owUHVoZG1ON05v?=
 =?utf-8?B?S2pnYytCUldpNTlpbTB0R1ZGMnVHQmdWWFNYU1Z2ZVVnck1BVnNhWXREa0tJ?=
 =?utf-8?B?Sm9TcTU2cmY2UTdZYkQzbUsvY0hSNWpVaEt2Qk9UL3pockNkcE9naWMySmFU?=
 =?utf-8?B?M3BXNnB4eWpzTVpyTG0zT292YTZDS0NkNU50V2VrOXpLdGYvY2xEM1BlZnBr?=
 =?utf-8?B?OG5DZFZ1Mk9oZTJoaUJ3eUhMZWNOYU9OaWpVbW45bFpHb0I3eGtscTZ0S24x?=
 =?utf-8?B?a3krK0NQcm1ydTRnOWRJZlQ4dkN0NkhTY0ZoR2VKVWxoL0VmRUQ4QmczbmEw?=
 =?utf-8?B?dHg5MERHVm9SSkRLUElYSHpidkNPd3dmNlBiTVNrRkxld1dmWkdsTXIzWnFS?=
 =?utf-8?B?Z25UMnNjQ3ppREkvcmk4ZWJ6Y0NFcVRPQUJ1UjlWdDZPemkrZU55S3pja0lr?=
 =?utf-8?B?cXZHUlQ1cng3N2R0QTBBaHROeVdqK1Blb0RtT29rQ2JKOHYySjBNK1g4dktS?=
 =?utf-8?Q?IzBvSqv5pGvGQCNrEjh4L0dJO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6247.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a26a558-e3bc-454c-83de-08dab2aa00b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 14:47:25.2245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: etuP6wUNBdz+MO9KquKQH6l7VwP06vEvAC6k+oChIGuOOZDSr6kkKqwU1/GoX9hPmdFhK7+672DogYtIMVrGqz2E+5XdBiFIMPFs1BLIQng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5629
X-Proofpoint-ORIG-GUID: mP_ooHIvIYf-y2DWNCnJAE_NXB179z-1
X-Proofpoint-GUID: mP_ooHIvIYf-y2DWNCnJAE_NXB179z-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_05,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=816 priorityscore=1501 impostorscore=0
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200087
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQoNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbWF4MzEzeHhfd2R0X3Bpbmcoc3RydWN0IHdh
dGNoZG9nX2RldmljZSAqd2RkKQ0KPiA+ICt7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiAr
CXJldCA9IG1heDMxM3h4X3dkdF9zdG9wKHdkZCk7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJl
dHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIG1heDMxM3h4X3dkdF9zdGFydCh3ZGQpOw0K
PiANCj4gSGF2aW5nIHRvIHN0b3AgYSB3YXRjaGRvZyBqdXN0IHRvIHBpbmcgaXQgaXMgdW51c3Vh
bC4gSXMgdGhpcyByZWFsbHkNCj4gbmVjZXNzYXJ5ID8NCj4gDQoNClVuZm9ydHVuYXRlbHkgUlRD
cyBkbyBub3QgaGF2ZSBhbnkgb3RoZXIgd2F5IG9mIHJlc2V0dGluZyB0aW1lciBjb3VudGVyDQpv
dGhlciB0aGFuIHJlc3RhcnRpbmcgdGhlIHRpbWVyLg0KDQpJYnJhaGltDQoNCj4gPiArfQ0KPiA+
ICsNCg0KLi4uDQo=
