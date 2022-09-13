Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5279E5B69C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIMIlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiIMIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:40:55 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11013006.outbound.protection.outlook.com [52.101.64.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C595AC73
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4eT0l5q7ZtpSQ14wNRtU2XqLejvxWoayjylZCStGC1woJoa/sS4o5YJTc85sJmax9BJJ3n/4/xZAA9umh3eXukb9KQ5Vi67qA7oE0uv726iVLACveRCNDKC1K5qUazDhOH4c5UpAnWllJGlRfK/Y1uBWBEv6gjYCsqbCLiA0FTk+wzq8mVv78vT9PJGvOE/bXcXBKPOqigoCZEUN8IjE+YWVUvIjsBvRZwD1yGCZCmOWTb4W+6f4LIpc7IJpdtpqlZh+v1w2wQxL5AT0upiQOwzxiwlZSPR7SuaErjbxn4cWPV/CMpgnYx657j8IGhS8PCDLZ37tbuyW/ZFyCtfKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXjneg1OQD0rq58X61UJ3gAsWZ7xCjcIeUMnZgpAXYQ=;
 b=Hx/no4bI87fti3kxpMbX858nXRIfKuMin32V8pY0rcc7hVLTMcywe+mqTPttwbIOS1Msdas1+C37cVHWBqvlwJnuWSSNqmQN9Pm1hdwX9mlbV03hYLiM5fp4KAFu+YDHkEz9ioQ20ZmfIvq/gseECodKZuKEGq46onGHGpdJo7ImG2sn8wGTH6eckTNXkP8W37DD34fB9DC2d68Vgoq6ifnhZ1PsORRohcgzYvTdctKmCMJkzVrUubRW9Jekx1qHNeeLDG4TpUQrgHFhzneB87FQ68Ng7KiewkvxprmKB+okOIBkhufIYVxnEKY3OGIihUVtFio/+hGgTX9IgMqxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXjneg1OQD0rq58X61UJ3gAsWZ7xCjcIeUMnZgpAXYQ=;
 b=YzpK+wu/dJzNiQ6q/prytvFT+Q+WZF3Hx3lERV0ixkajxFoMkHeq2u1xiXOu72pt2gjMqXnFpMA6mg/o058MwBFbcGdjBYjJGTpuUqX+ttpDleufIrr9j43N3baB0qk4styNzi0fhEjPI9KDf2L4AsY0TiBSO7kvlPB2kX9xq8M=
Received: from PH0PR05MB8448.namprd05.prod.outlook.com (2603:10b6:510:cb::13)
 by CY4PR05MB3621.namprd05.prod.outlook.com (2603:10b6:910:55::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.5; Tue, 13 Sep
 2022 08:40:49 +0000
Received: from PH0PR05MB8448.namprd05.prod.outlook.com
 ([fe80::8c59:4f41:7586:c620]) by PH0PR05MB8448.namprd05.prod.outlook.com
 ([fe80::8c59:4f41:7586:c620%6]) with mapi id 15.20.5632.012; Tue, 13 Sep 2022
 08:40:49 +0000
From:   Manikandan Jagatheesan <mjagatheesan@vmware.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Peter Jonasson <pjonasson@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Rajender M <manir@vmware.com>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        Kodeswaran Kumarasamy <kkumarasamy@vmware.com>,
        Rahul Gopakumar <gopakumarr@vmware.com>
Subject: Re: Performance Regression in Linux Kernel 5.19
Thread-Topic: Performance Regression in Linux Kernel 5.19
Thread-Index: AQHYxD76FSnznGGLrEKJhYfY7fdHzK3YTAyAgANYowCAAWs+Pw==
Date:   Tue, 13 Sep 2022 08:40:49 +0000
Message-ID: <PH0PR05MB84483065597B17B361CBA9ABAF479@PH0PR05MB8448.namprd05.prod.outlook.com>
References: <PH0PR05MB8448A203A909959FAC754B7AAF439@PH0PR05MB8448.namprd05.prod.outlook.com>
 <YxxCMSYaI/o3QH03@nazgul.tnic> <Yx8Q1L3jNAJxa84L@nazgul.tnic>
In-Reply-To: <Yx8Q1L3jNAJxa84L@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR05MB8448:EE_|CY4PR05MB3621:EE_
x-ms-office365-filtering-correlation-id: 69fb0188-63ef-4411-6bd2-08da9563a8fa
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +piKJR0diTamT9LX1s/SKIM8eeMfnpR/oMf4bZQmHRkYxSboYfkBo4jK5/a4mu01airQpuh9ZfSjlkFDAR1GQ7tdAKNYr9G5It+/X14pdqgbLiFVi9PulzsrtUq21DNAhB5QsBsu3tzLKDRg0JBfCgYnR1PLI22qh0NjBFUM1Llv1b1vXUbB6s0C2bGgnt699wG8vf/LfbHdCr/gBCF6EygLtQfLxsl5CwypWfSZoEaSsZr73g8CjXp7uZBGK9mI36vAeyY4l6O78XRQcEf2XoGXAGHpJo24O8eq9iC6NrwxcapqDw4sFiHMZH4yIeUs2BY5v7tfsUe4TsIDzYfN7sijaAlLjwce1W+Dn4hCHHAZICbuIXK1FrW7VcKOP1A8biMKU6u9Q0o5q2UEDC8SxwsnaAqfbhkJwExE+lhAh4PLN+1OAOZll+aHpOPWS871BKyjv3dfQ/U3hoyb7k529QOiSRVnshJQJrob6PTT6dcAbzzMDRJUlLw1Yyryk4bMP1Vzh5cPgoOtmGiExkhqKJGUA1pGQlghvsZpIgJXEACmiqk09gtggG05FE3sRmcHy5zSaIdOSJbFHm70gvLIcIWCIa1Y92XLIBThWP6i3hV9v37R1sRNltsL+hqnIBfViHfTKlPyTuXhyPS55ecfb/yml5vyKkWx2zKKMHGYNqBBsl9EJhIdQjiXX0v//6sXdJVBjwa8/cz5/VXVtTpnGJCnZdHbSSw8QQvOteK8MqyrZkEaTtq4DeRy14q+Xe55f1lrHckPhcSRQzzKWju9ldl0KI4rjuYQ/FlxXqqyDLH0w6IkOTcufGmsGc0NDsR2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8448.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(41300700001)(186003)(38070700005)(66946007)(83380400001)(8676002)(4744005)(54906003)(91956017)(2906002)(52536014)(66446008)(6916009)(64756008)(66476007)(76116006)(33656002)(9686003)(66556008)(478600001)(316002)(6506007)(107886003)(7696005)(71200400001)(4326008)(38100700002)(26005)(55016003)(86362001)(8936002)(122000001)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9DUSHNs0M2+zh8dQ/o9zF9YdEP1gD0ZR63y1rLgXamaI4Ly447FWajs/+r?=
 =?iso-8859-1?Q?K6R60ldsHMId0spILkvXKmycF8NpB/BrfoTU3Be3Vv9ApQOCrnbiWVXfTt?=
 =?iso-8859-1?Q?zsEovmddZ39u3HaTKJZ7SDdZibqHizwbU1FxgtmFF1LWWcISeS/+QXvgnU?=
 =?iso-8859-1?Q?kuHrg4Qw0akSto7TVU061C3+oCrSpUGN7DTcDZg7HM8xO2Ou+Mgc6+/VWH?=
 =?iso-8859-1?Q?9EumJT9TM91LKMm1N8ffvHqKo3SY0Tpy46+iua9+JpgPSKVFYZN0AWxK3M?=
 =?iso-8859-1?Q?8UxPg5Y7lpvrAhFXr3FSGX/92gy6J7uftHneZLVDSmzY+YoreWOqL+QDMm?=
 =?iso-8859-1?Q?EFPe2qMGoP/mCvBhhfLlqNm6dINbfsBy9WdpxOr6Gnm+MGdLkNm/zp9gi8?=
 =?iso-8859-1?Q?N0UFFBU8ifuow7seBKuyhHoOe5BEnXGfxSVrsuxeDOWKHKxC4+yg8TkgaV?=
 =?iso-8859-1?Q?8cptePleybjT04J8Aozh0jB4QAOBqslvKUUzKzwLP4lYERL8bNLCiyBVI3?=
 =?iso-8859-1?Q?SuOs3qU+M+Z3cZ4Gf0KDojrqeEEWe4GeVbld4ohXMKW7Hv8TIA7X3+jPrS?=
 =?iso-8859-1?Q?5+C3afEj5ggRdJNG1uwTFUX0ewG7Nz6MJf19HxTB6pSQOwegnx/zcQ/tSI?=
 =?iso-8859-1?Q?Fk8npo/OU8M/dtBdXpa/LTXqKxe34J0mNYmGMWv/TeDdvEpJm/1zqxywLT?=
 =?iso-8859-1?Q?jUbtKarBSz+TWpeiXQ1o+emaASlAhJJ+33HQp85Iws56i/TSEPvCdGSf5U?=
 =?iso-8859-1?Q?uI9e+a4EjTol6kSN2IIQxB5zuX7omtqEIqy83BQjUrbQpkimB/mZaUd4i/?=
 =?iso-8859-1?Q?g7OCIW/FGFXLNwRtpLyls8bCfaHcYIOV9kCn6KODMmD+NwiOmSUZW/FbA9?=
 =?iso-8859-1?Q?E1zBBdoryL2vdlCPSluHYHZVru8ElySUTtXvCTMvMZjR+eZuPxIecYQXQ1?=
 =?iso-8859-1?Q?YZVVMSzFttO56VtRgreVmUS1rlarfOrnn23oF2kLKxIVlu8m6YRxwEji6V?=
 =?iso-8859-1?Q?GZUVMf22TkSIIL3G86pIfc0Ww3myEGZeK/Dvjhp00c/INj2C4kBTaGCOIg?=
 =?iso-8859-1?Q?ofiD8RGLcwQ1I5bmqcOtWBn4AXMXtbQ8vyufibHwAt2oBxTs0hIQg3JZnd?=
 =?iso-8859-1?Q?soHZ/vX4POaQ6LZNlskUKziZQbwWXNyCCh2m5nAztE78TzQzf1n9SDQW1J?=
 =?iso-8859-1?Q?7O5wbj2XC97r9AeFvHUdzuP/g+J4xB6FN/FYWM1c7YptOuKf45QIDQ4pM7?=
 =?iso-8859-1?Q?Zo7vI+UjUYRQUCzI0RWOaCp4eqAZY7mpPSrXBJx4EB5vOfQPpwpmpm0z0C?=
 =?iso-8859-1?Q?3SGdZPc+NhT6vOBnpn2w7pRbDOFYf2V2Ftr3jr2CXr+5x5pir9XU+PP3tC?=
 =?iso-8859-1?Q?2yotRs7CSZ159Gzel55ngMyEVOL/CNUIpA6qvb8WJVExoUzEofTigPm6ET?=
 =?iso-8859-1?Q?1ht1wAhIqEcs18VIOsDpN4thQoZ8Y5/n6m3Hxk1o/BDXi2m4XeBQuWSpbb?=
 =?iso-8859-1?Q?64Yz8uabQHc7W3YK3r/RQoB8mU6/INJboXEWBa1MvAY97cJ4LVKfBjNcF0?=
 =?iso-8859-1?Q?Ok/CvAHXeETDIe2AbeQSLF+NNE3vJ7PD5ECu51pEzEzaZXhlf34Tzyl2J3?=
 =?iso-8859-1?Q?YXSR+XQ6FuQQOGs3HpMN2TlDRQz31OijfA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB3621
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the responses,=0A=
=0A=
The underlying host CPU architecture is Skylake, and we are using=0A=
default settings at both Hypervisor and Guest (kernel) level.=0A=
=0A=
Are there are any ongoing activities to optimize the performance?=0A=
=0A=
We would be happy to validate the patch (if any) from a performance =0A=
point of view and share the results.=0A=
=0A=
Regards,=0A=
Manikandan=0A=
=0A=
=0A=
