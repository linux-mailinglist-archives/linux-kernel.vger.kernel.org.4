Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE54607123
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJUHbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJUHbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:31:43 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11010011.outbound.protection.outlook.com [40.93.198.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2820239213
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqbv6QJ6ZR6/90zOFFs1A8mw+zSdpipDfJkK0GH5V82JMTMRWdkFX/oF+YK4ExN6vidsyWYCAAwTpPmeEerbPkHI22ld+9YuY96Sf1zmwrGUl0LH7YNwcchEf9qH3+MOqYu17cl8h/9CkmSiqOe5UnaUaIaI3SfVqb0M/inKtkhaxcEcWATGydZk5hQXtRYqB68Rx2/6O+dyjFHVO3zXoQvdPF9uzGEklrXhxxjOBO6leFbC+6SoB6fauBRdC2wxvS6ThGN/LYzqYdSf5fJSRpwt2GQrXDvN8nNHPmPFXCw1/tnuVzLQyBYre5lImBtJhZhV6tn+HND9jN4jrrqjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3FSazJB8dcDLTPJOXOPgT3h9jnDoIhg05C4u1UIiiA=;
 b=OiIFBuGq7/rmqr18/1WL7o9tJH6W8YvfEerjHmZipU0bOlrf7hq2UtLESJORCNi2qV7Cdflma3KtUXi9541Tze2ZO/W08isi9TaQuKFCJXQZCvUL1La4pcKFbH1k0skxAhqCeQ1yHbWw85tktNX5Go19RvKc+hZEarSnCMsRsrofE4FGk9+al1QeOM46XpGG1Stc659qY8yiCP9gl83K8VVGNGmRX7eftyO5fCiUhFXtWT0P9QgkgRGcGZ9SrtchWQBu1LYdCS3Ij9yUU/xqdUI++ym7XRHoaqkjnUl2noNXVq437YQ8kpGA4SyaRwH7Jxr3RmxNHnkcvMNDar0U7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3FSazJB8dcDLTPJOXOPgT3h9jnDoIhg05C4u1UIiiA=;
 b=18zWY4I885w3InLRglTVZD5n95LEJopBq5QNpx1u9kgx0YNNJa932e1+kx5G422ayb5nm3lDG1ASgcnjHzQU78tjEmFP5ezhOxWdF0xc9RMgjeLcoIucJ73vTj9g4r1pJEMZHJmj4AkZMEbrB9VE7399FywW5OfB264NVCKvkuM=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by DM6PR05MB6554.namprd05.prod.outlook.com (2603:10b6:5:124::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.10; Fri, 21 Oct
 2022 07:31:35 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::942c:7d1b:6b3d:85b6%7]) with mapi id 15.20.5723.028; Fri, 21 Oct 2022
 07:31:35 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
CC:     Pv-drivers <Pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kernel@openvz.org" <kernel@openvz.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 6/8] drivers: vmware: balloon - report inflated
 memory
Thread-Topic: [RFC PATCH v5 6/8] drivers: vmware: balloon - report inflated
 memory
Thread-Index: AQHY46Ei2elIbCkDckOp2+Pbz7tY8K4Ya5CAgAAJqICAAAHNAA==
Date:   Fri, 21 Oct 2022 07:31:35 +0000
Message-ID: <CEA2F8DE-DA49-4DB9-95F8-D0864048353C@vmware.com>
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
 <20221019095620.124909-7-alexander.atanasov@virtuozzo.com>
 <39FA848F-290D-4110-B27C-8822377E6AA5@vmware.com>
 <627d2c7f-8ba0-2910-a98d-ef42b9dd5ade@virtuozzo.com>
In-Reply-To: <627d2c7f-8ba0-2910-a98d-ef42b9dd5ade@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|DM6PR05MB6554:EE_
x-ms-office365-filtering-correlation-id: 320d7a90-c554-48d6-28f9-08dab336487c
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPWLGqd+1AEoId7tUirBQNrRKlimm45ygsSA8TMkzswGUYIE3PhjWVi8DD0wZ6Mhm106GuFZz9lADeO4q3LHexE1+pgH8AYCNBE1E8GEBLqyN8swB1cyRB2gPJbjYIImNEe/sJLEx2o++VO/KfigUxZ+KR7pnboBFOReuBNYS2KcY+nGHJcRxh1HOTahDF53XY95lD3K3MHIDpiIfs38/ict9HpmW5fSyt1DvK/zVGiwTSh452pB9lAt45JMKYo3KBMmPo7ATbjF8mSR7dhy4ibmek3euayhFRyckBEHNtNwp1o5uIpUYVmQNNHLDoG5UdZ+mnNlz4mxnY/9C2v+7TsQxGagQbviIefG7N5HLTWrSy/RJv2LFhp1lcXw9/QfiEwpzGJVERIBN9Zi/3IUtpDQGcV7N6fnJBuqX6rRNHwkXlVczBNFNGgCDFVedcMZ27M2nVoAMFXxFUcpHPgMMOJwx9TKqgfQUDUXxK+7SrusJ9HzXEW20hW2e95QyTuIAJMcKVw2dNVXZdwfCNdZhCA2tozkbCi5MFWydnvPq0z9HTKzsywBFkPghRVFNtOoqRATzHHGui1iOSiX29yASJ7ObM7Bczi0L8vbZVxpwVURWXsfKeXsO5k47UWsHc0j8ATKiFQbw5w3S9zc9w3Jvu3pGvBrellEfAS5UE1lfrGey8bZkb7Jbv9+Cz5lKVcExnGO2zN2EN0lULBIcZ306CqSznG9RzKKSxhMbBy+TtQiT6sPDGMGWr8gYCUNcJRuU1QegmxBCBAG/LcyCMZmpq3lsi6nn3MwNkeB5OJV7thb5Wrb9mhxGXqbX/gS/zcXJkOLwy9fQWao2j/hBvEUzmhIiC1sbUFy4+B0pWsHUDg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199015)(122000001)(86362001)(6486002)(76116006)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(36756003)(2616005)(53546011)(8676002)(6506007)(6512007)(316002)(33656002)(54906003)(26005)(4326008)(186003)(4744005)(38100700002)(8936002)(5660300002)(41300700001)(6916009)(38070700005)(2906002)(83380400001)(478600001)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OI1Ie8J5ZN2u9LmIJhNS9WAPxQ1k6ORzkciuPBJcA3VXhkpFCOrKC0w9bxzh?=
 =?us-ascii?Q?WJsuIDs/Q6HHiRGFWmIGNxH60ECl+5DteAAraxwz1Ke31OeGJtYT5H4+MPei?=
 =?us-ascii?Q?B5/BmMJCFQlKiQZKv4IBUtB06Lqqf3RVD9Pmyvxel2k2hunNTFjn9D1MXw5b?=
 =?us-ascii?Q?zoGlfMxE2NbznDFwMaTlMfBB0AJuAI/AyWr+ac5kyOZGIQFAAEMzTLJykCIQ?=
 =?us-ascii?Q?HIwL6ap1AiId/Xqof3vK+WLEOdQL44mFQFuPu9naNraZYRojlBlkco5hWvXH?=
 =?us-ascii?Q?pkun7W14Ofa2gF1jaQNi2lOAkC2r1St+MIUQfCZoS2LgimE/MJlRsH6Cjqau?=
 =?us-ascii?Q?hRivDpFiuuexjmPRpazV0JRPFFRO6gWKlT6C7dS+oEbrmBDRHl5hjihC966q?=
 =?us-ascii?Q?5JbC5MaIIULwU+IvG3qu52lBnphwGyc7UrtO2nBQ8l53Ewnd1oG68zd+d9Kv?=
 =?us-ascii?Q?rbW3qB50RNz61odi1P4AeNb1pM2QJVw14r+R3WGctipL7HQ+oRIbB155hr4u?=
 =?us-ascii?Q?oIWfXGMRPBolUe5+wVnK6e+CBvqRAQgnHzv+HfwptmdySWFLgagKXv5P4qj7?=
 =?us-ascii?Q?rQc6f+Fhs/ch/+VF4FJ55tCE6ZMfaj3sXGEyHfhp6S+AAgr097JM/QYr/VRG?=
 =?us-ascii?Q?ChRyRHDVbKQrdA2Pftb1YbANNUDEX4aoUYgPHDR5isgiXwJth0EQwt9nim69?=
 =?us-ascii?Q?uYJwlMUCn+LZl907LGl/VkPgRaDxPTgZqVeL9WtJryGlmmVeAufMK3Q0OBzr?=
 =?us-ascii?Q?7Xq1A2OLT2fvcjQ0LoDAaLsuumUp8jE1f4tQ7tPbseLmON7Ao8WRJvLVFrXN?=
 =?us-ascii?Q?LlRlB5Iq58pe0/D9w5Ec9ei58GG+fSLu+bDsj4Dq6p4b1nJfAEUASS/1q/TU?=
 =?us-ascii?Q?zflIs+ScxMm+AIQUltjfmVpM+NMVqGuE2AZsKI+NnAhc8jcOvDpnR/U9cgHL?=
 =?us-ascii?Q?glP/IKuxRB7us0ya3qnAZL04jmQFxUbYSy+yXlRNlHiw7dBHxmqW3BoTzrvI?=
 =?us-ascii?Q?g8FmsnvEsjt3qbFWkckM3ZYFVVvAn0SEbIci87mwkk+J8F1d+BDldVdgqCC6?=
 =?us-ascii?Q?ecNecgOjF4KZgRZlW5eT0sF7CNHqVN9LPqlM9U8+bSVXaC8RvzdXdoUD+MG1?=
 =?us-ascii?Q?q+W5bh0qYVXMs4oQObo35V/F23D1wSqVhyqCkuIuStDJfeXTn5+sHxx54e06?=
 =?us-ascii?Q?Ze3t1mRNYy3b1wY+R2O9b6lqr1L5lCNggW1pjgVIwbi+dY62AmEOi6zIdHq2?=
 =?us-ascii?Q?DlVVAFFvsOKnxSLdIK/OOOsoTH73u9EaRfsuyvrnJKbCa1cUCkxJ4mpunHNF?=
 =?us-ascii?Q?tRCIfOzdL0gMcJT/AEMGzesi/9dnWpoDcWUpwlx8b4IrLkGQFa/JZeLYu0lT?=
 =?us-ascii?Q?DvGzfUPm9ijLt+RsvaO3bkZTC79DAhJRvf5apbYEU4YOjLpv6XAYR3qQQp/y?=
 =?us-ascii?Q?eTDYs5apNLju3/klYiLlb+jOxI3Loupfe2LPXbhZN+MdrFb/qbbaaT+hUEO2?=
 =?us-ascii?Q?DfRDSTahnZBTbDHF1rSwN/WgQHDCXn9WiSjXOczNxBm7WAQc3S0SQCxIrolL?=
 =?us-ascii?Q?Z0khZcI4oviZOOJH3rhNTdVcii/q20PlFu7jdJ2v?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <60F9F84DACB5A64483BC8910D7B7883C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320d7a90-c554-48d6-28f9-08dab336487c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 07:31:35.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pH6oIco3aKaGX+IDErNU94eX7DtoHFulus/Llp4C8K5A9C1x2HpdzGWf6aY+N/cusvpiuhPIG4t+EcdVx9ZJMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6554
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 21, 2022, at 10:25 AM, Alexander Atanasov <alexander.atanasov@virtuo=
zzo.com> wrote:

>=20
> Ok,I will move it before the enqueue call.
> But are you sure about this the reset?
> vmballoon_reset(...) is called only from vmballoon_work(...) which does
> the update ? what i am missing?

My bad. But when the module is unloaded, vmballoon_pop() is called.

