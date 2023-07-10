Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BDC74C9D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGJCRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJCRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:17:05 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013008.outbound.protection.outlook.com [52.101.64.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E37103;
        Sun,  9 Jul 2023 19:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/hcAL02ZvgwC6dC8NwGuSYvbG5g86JRPpDY1kYS7p9iqOcOx9cmD8fKc9uzQMIRtNZs2xeSYgUOh9n6F1RXHwrd9U/ZLzXdZQoNu24rbmj3FcYSDZHH0ZoJOeav1+J7DJATItPwM/f94xxJ3HfjDJ2AKXglK/HZTc8yK2OASMShnxK6nf1hLK+eb+AG7p5P1rVIqAZ41x5j7spr3Ms/6V8DxWF9Fj36BwJzhtz/dvIXEwE+Dd/NXILtiAmrgbB6y5X5Fe8NFrEBKtRmqePb11LVkByazDfh/mIxkZdXVyQJA5PJ5asm88t09cG15YgRfJybUBmOsT8H9gLPH9KPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCKafXkL268b78Amzvt/Pp/jDLp0lkSd6+dUuhzhyyM=;
 b=Vraiyk4tuC21Z89DKNSs0Vabwtw3MIyIhbrALc1kqA1M/PyX2Z6jHGVq3QNKSjKwCteqdUwsnlTNPmj7J2EkCAx1nEDBB4wv567Ti9Z7ffHiG/Kdhg1PXHnIDbuiO5fPMW6k2lQSMEimORzMEqqh97XRmSnrkztRMPRFJov79XDaBv8UtjpCwxh3HgA42ZkS7k/T+NBZ5QaO/q7FAI8SUmXa4zS3l8vJG4UxyAN1I9t9mJRr/lzrGk3OFT5Qik0nCARkdwxD0+RPLfJy8OzPFIigSiuv8TRjA4PD+Dv9MW/CAVgZnpVwCqBGPyRnfRMJrsieZf0+NBRLd+x1xsdBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCKafXkL268b78Amzvt/Pp/jDLp0lkSd6+dUuhzhyyM=;
 b=yasE+D09W7Ck6wnnh4ApGN/+grDgMs3jbPnsKV7JxNj085gPUBzUeADmtVrGUp8TVh1MMDUtpfJqTIrhcJ4qS8/XH7s1U0bGDAZpKXCdvd05+87OivoUynlrkcTvm/pgjU9t78NAc9t/4qVLog7CcsP7EmtJB29JXovWAbnLnxs=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SJ0PR05MB8616.namprd05.prod.outlook.com (2603:10b6:a03:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 02:17:02 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::45c9:cdc8:ff01:5e8a]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::45c9:cdc8:ff01:5e8a%6]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 02:17:02 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Ajay Kaher <akaher@vmware.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org <linux-kselftest@vger.kernel.org> ,
        Ching-lin Yu <chinglinyu@google.com> , Nadav Amit <namit@vmware.com> ,
        srivatsa@csail.mit.edu <srivatsa@csail.mit.edu> , Alexey Makhalov
        <amakhalov@vmware.com> , Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>, er.ajay.kaher@gmail.com
        <linux-trace-kernel@vger.kernel.org> , linux-kselftest@vger.kernel.org
        <linux-kselftest@vger.kernel.org> , Ching-lin Yu <chinglinyu@google.com>
        , Nadav Amit <namit@vmware.com> , sri" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v3 03/10] eventfs: adding eventfs dir add functions
Thread-Topic: [PATCH v3 03/10] eventfs: adding eventfs dir add functions
Thread-Index: AQHZlGebsT+aXAuaRUetlt5BX1Xcmq+lHj6AgALm8ACAAFKWgIAAPiUAgAARDwCACdM7gIAABikA
Date:   Mon, 10 Jul 2023 02:17:01 +0000
Message-ID: <1C0CB205-B56F-44AE-B9B4-3668E06C840E@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
 <1685610013-33478-4-git-send-email-akaher@vmware.com>
 <20230701095417.3de5baab@rorschach.local.home>
 <ECB0097D-A323-4CFC-9C9E-D4DA2AA6E662@vmware.com>
 <20230703110857.2d051af5@rorschach.local.home>
 <84CA259A-8A99-471C-B44C-08D289972F43@vmware.com>
 <20230703155226.1ab27bc1@gandalf.local.home>
 <20230709215447.536defa6@rorschach.local.home>
In-Reply-To: <20230709215447.536defa6@rorschach.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SJ0PR05MB8616:EE_
x-ms-office365-filtering-correlation-id: 4571942b-e33b-4256-18ca-08db80ebbf53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: In7jGNMm6BoDOTUvMM+OWiu6P1og2MJvPfJZfJd7IqqZcY1Jz6eLC7RL2kMOS8En6z0aZqUe12jJ5tS6VFi0OcCFfJbINdbQ9PSts/DIDEZh5vwlloF7jXHlgSVdvIsU2vXd3kQy+yK8Y/cEuAw0z2W+xrgaMqTndcsEF4wQu4IIbGdofBjnQo+rqFgLsp9MBT2UPsTFe/lGpUUCnfif/FTV1G8hFxWd3oQJPT4qsYGsFBlSNd9ncDzbjXDFef8GdYcNE+wlrwrXXvMeWpou/t4g6q9497/yr527sFlgKspVn2qxCcI+ilI6T8NjPYmXFgV0lhQHRh5b/5fUftTmFBVRCk5vAw+KTnzo8dxlAv/UYen1Ev9zwXYf/gvN8d8ddMaPXUX4msojQM0iQau8Dt/Eh5qfmd2lQKFI3xZKHawV4sbLUOn2nPWsCrEHQX16Ah7cmFOiXfTnKYwiI6U+9VJ4HDmIqW15HSYl1aivZB2ASRBGEyAdVkaO3XyP5Ybo7cokN3Ash/OicbrKUXUJjfzALOKZOp2Sz7K9VI8VnurwcdqWD3hS9liofMR2fROD3A/dYCjq+TpMboHeNFBb7LCEEZg7iNfbGs9lYdfMAcWniqddE9478UREaNsi7tkLMOHo1QPQay47+GW07IJ96WIXsB4ekpKi05dQEC5rvV3OV9pHTgsgmjm7yCY6RokFK6GvhwnURCYM3tfqRGFm/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199021)(186003)(53546011)(6506007)(26005)(41300700001)(6512007)(2616005)(6486002)(478600001)(122000001)(54906003)(71200400001)(6916009)(4326008)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(38100700002)(316002)(558084003)(86362001)(33656002)(38070700005)(8676002)(8936002)(5660300002)(2906002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KawEVWT88ul37xZOmueeZzl3fImQdZY6KFNp6OlD4/gvS8WEpWjNxiIbjCOM?=
 =?us-ascii?Q?CT5jpJ5VDYREWqIKjGvW9PnxcDXwTYvhPV8JCyrlqHURzbcsHw/Rto5TR6Kr?=
 =?us-ascii?Q?1Mvc9ElDjv9c1D2M0sBtfLM7xM7xtee98OFsTsjwBUa3aH38OJwTHmM+yvBA?=
 =?us-ascii?Q?nqnEqXuFKPEZuGKsiiDClu8nHny+DUUcBDBgdK6r28i34v7FVpo9l9ZVfZee?=
 =?us-ascii?Q?19V7IElsGHVevENSORcqkMdoRxqu1Vby/CKjpIEsnDAMv40apW7UbqMuzl6y?=
 =?us-ascii?Q?Ty6eKPsWBXHJ1atDVCePe9ZwLoTz5cbLYwOlDVCcr+wYtuP00Dnlu4OiKC0p?=
 =?us-ascii?Q?QFNichcpUt7fZrFbgQumqBfjQtSGv8StrVSgv+Xm3KqAZ3COqzBMmpdQAqlu?=
 =?us-ascii?Q?gUclAk8v6YDvozjT/8ssubi/jaEe41mAjj1ji74ojRF9w534Vv5kIfXzuW5j?=
 =?us-ascii?Q?yMMP4BGlFhY4CZkfwXbXY/u8UAhDYAZWqbHaVaAApuTqVZfc7urrJm2S8m7n?=
 =?us-ascii?Q?SrziTuWSZWUJ/BsOwgo6/IirtjjwnV5XUlxAB2HILRmtVzQqOo3HOVmJGdGm?=
 =?us-ascii?Q?yYvrzxaItLRdnIZIsn6q0WhDSeKNxVYKt7a9qAuQk3hkthuQ0PoFHHZT51hU?=
 =?us-ascii?Q?cim26b6lEG+1qRrr2WqctX27RyO+ksLiA2bgdKnDxL4BscfFjykBya5Wxjb8?=
 =?us-ascii?Q?4XECMsngu7jSExuINGt1+w+nlyhvipOhOkABWf5SDyBDncEz/kvPWSNMmYJ1?=
 =?us-ascii?Q?kwL2eYjAz2PWaIIDU5ofQT8A6vs9259rph4cx2NpOfLsV7O0CSE4LpTkuDQc?=
 =?us-ascii?Q?b98PTGlUeeFkkDnWSUDTwlRQOkf0BNrGbqOnjQlM/nfOZ4bT2NHQnxh3T4OW?=
 =?us-ascii?Q?V2Y4dpjSfDqWAxgjGkl4hSvY6VmwtdjOP1pHjhaMZkAJdesrZWThIzWRS/jW?=
 =?us-ascii?Q?VQllqbPkyC5vL58es/cAxvxYVbYTdiJ7eCspVzKz53DnrBs+xTqysY2EG6AB?=
 =?us-ascii?Q?Sn1Y+bw3vBB9QghTE0pm8VWF0QTUyiTZf4W5Uoblrsi9wvaBffTzh/+ujTNT?=
 =?us-ascii?Q?zeJ6sAbCXLB9Khrq3kk7/rkfVwgmdFxnZRwmhRRDcv6t92/yZ+yEB82wPrKr?=
 =?us-ascii?Q?5INQdHulRM2sMhOTmPC66ihg7p/NKkIiuvX7gl09676LvmoXndvoku5OOgEz?=
 =?us-ascii?Q?SoYN21xNz+9fnruGZdsZ+0/E/U/yHNJKexr4JpFzFVaI0UhwFjeb7rrjm8kB?=
 =?us-ascii?Q?wQ/T7TNLkGN45e6p15qplkAHm4+zUR/7Vk6FS1rkjg1Urw+8dLZqyoRHsEIy?=
 =?us-ascii?Q?mN6mUNEmuC6gEcpL2cwaLySEj2PmzY54vldlHYPbMbo1PqXIuzP0Sssr1lH+?=
 =?us-ascii?Q?gu0on66w39wo38TJen3LWvmEl90UDK5z9aiWeRSjzGKj48YJk1Bz7E+TcFup?=
 =?us-ascii?Q?LjMG+1EE52HjiyBjEeFAD+e4flmGCup+zBO9E1eXsyV8zDkDPzrlR2sT3qC8?=
 =?us-ascii?Q?QX1QDr48hugQaK08RUIt3ffNte5IWgbdTEK8q9JwMq7MkKV2ctJieP6331VE?=
 =?us-ascii?Q?08ub1aSHucgVdOucZs5Tcs8K2N2sjRQT2iszfjYs?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D1DE22E64886044A31E46A8397B0014@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4571942b-e33b-4256-18ca-08db80ebbf53
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 02:17:01.8555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9ZyF5fDjL6qaezPleqfzxqfgXFEAtyyNLuU8Z5sVgQjzG457lndhnuiIcnymZAFWvHiidUX7iFJ7833g5ZAyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB8616
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 9, 2023, at 6:54 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> +       union {
> +               struct rcu_head         rcu;
> +               struct llist_node       llist;  /* For freeing after RCU =
*/
> +       };

The memory savings from using a union might not be worth the potential impa=
ct
of type confusion and bugs.

