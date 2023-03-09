Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9495A6B271B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjCIOhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjCIOhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:37:10 -0500
Received: from MW2PR02CU002-vft-obe.outbound.protection.outlook.com (mail-westus2azon11013002.outbound.protection.outlook.com [52.101.49.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036DCF7EE4;
        Thu,  9 Mar 2023 06:36:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEG8PfOh8rJgIwG3FURqlckepN3T2lHzKVS3PEIjVG07KJk9hzwvDenj3fDPvrjRDPb7bbIG3L+kXMchT9q+PqsGM0ham7S6CsTHvNgL5oMKLG9ol7f7FVaqLZncWpbIgILXQ7m90RPpFbLzlFP8dW7jeqlWlpsjZ+IujEIdelIExEV02up5yUKEbS3PiwAKQlnfO4yVQmTLQW4NdFy6mXGUx/G+4n7ffgd2QzuG/sga/ywWOPtrKZAtO6j3+JOZIjaPem8dCEgERVzQKkpz+NPr+Izyxti6uA3lwAeVoBLywC3w3hlLIyzt8npsqizzFpQ32zP2Wiaod7mB2zL3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uw7L7FkaLkTiWZpQ2U5ZMMyiTeoKWWWefW7WvmFFsQ=;
 b=V/SVrJPlllRkkDlpC/ltZTTobMnPUWC1tfQytJihrwqHZmxbN/mm0xbMRzMvfT2qEHS9bId2/UHnbSFdk99uboIbBieAuBrHLSv7EAbRHwCabr0MnNXJ1H2Vb5ZNmidQhYHn6mVU53vtpQz9Zz0L1qiuPQ7ZCJr6e52S90iOk/JpKtI1yonIAll/S//ZC41/A4JT9eDV5v/EaB5toc2vy+alc3ptTts1x/9PQB8q9q+UgkcRz9KGdaJs9BY2oKw46wTyy6xZ38FDgtrVBXg2TU4c2WgFQZF8wN9jeIfTpSgqJkZhxYsuOy3HtLo6dM3JX2j7mBysrXSBUgqAEucd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uw7L7FkaLkTiWZpQ2U5ZMMyiTeoKWWWefW7WvmFFsQ=;
 b=gGJylrlkvz5rBewDF1eyjG9LSgtr3ZykIjvp25Ay3modcwTQ5MEUA4Rx3kQAd9BTko4axC4z9DDKSjNWLUJbicwA52YmM/XSehKlKPvFsdTUp8L7FpdZc6ruq5psHftkTrgiHCGxuv0P7nABOjFn7DeBRajswM65lEceaXgpjYY=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by SJ0PR05MB7486.namprd05.prod.outlook.com (2603:10b6:a03:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 14:36:52 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::2e0a:34c9:2c28:78a0]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::2e0a:34c9:2c28:78a0%4]) with mapi id 15.20.6156.031; Thu, 9 Mar 2023
 14:36:52 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 03/13] misc: vmw_vmci: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Thread-Topic: [PATCH 03/13] misc: vmw_vmci: Rename kvfree_rcu() to
 kvfree_rcu_mightsleep()
Thread-Index: AQHZNk8LqGl6mptIS0m15e4cEL6+UK7yvIKA
Date:   Thu, 9 Mar 2023 14:36:52 +0000
Message-ID: <76DE4E7B-D642-481D-9FFC-D9B0AD74A3BD@vmware.com>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230201150815.409582-4-urezki@gmail.com>
In-Reply-To: <20230201150815.409582-4-urezki@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR05MB3960:EE_|SJ0PR05MB7486:EE_
x-ms-office365-filtering-correlation-id: 13f003dc-fe31-4513-c81f-08db20abb935
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZIimBrj33QIfc2jiAEZQwJQh5spblQ4Kfy+H3zqZO5ha2xzWM5F8AyIh26XQ8IfQzv29vZp21gm2NARKNCGlnZ0EY7sy0xnsvHBr/ASMIvogex/EdhoMOvIx17fRP45jga9Bh4mLpRzPXg4v7icCPQXfGl+Mn9MscjT56GyUtcGA8l7ulY3BkWDkoxajqWeiMXCMR6cAnVQD7R1oKchSxziPERZlRMm6hNAMaIFvhGWfra145x6Ep+aX62U9RAcPmSYNPgCNRj0Ue8xoRnyL8oE9z8+DJT+umnAK9M9RiGurbakP4VKj9gGTJJ5Q/su6qapsZwr0Cv/BVjnmoFZZ7mFgK/05KxzSLCN9jsd8Ofu9mH/BL2e+bn6yIsOKkUfo49/hv4mADh4i/qFGuTnS0WTU0So7ORM91GFPxV77lUWpOFuPgWCRvh6TCjDp/JY8b98b9tcqR67948JYZlpHKtvfARC48jMIZOE1gG3GmFlCGi9jf5QejEFkkHxSMzFNpWi6jbspXdUCqyUmAuk/TI1diIok0rZyfoQ09CsaiGX/wmmY9YrJDCsNvJemSIdxQ7SwE4WEMxNSuL2ekj6DbDllRykJB5G64hLXUt6Cht61sFCxViLSCSUS/BY32iPJrs2c9F3MVDiMnfyCqjjuNK+2+Zxkai61o0VU6qiSxSIf1dICHED90IFYkq0PAD39KGz5sihUff92m2GcTczebC6rG1O3g4BV66nakxTv3LPbxJi5jKRUTaBvRQNMtG7qyeAHmUEjrTkE9ihroPgorEZoqYkCacxY/rL51eUs1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB3960.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199018)(66899018)(38070700005)(2906002)(5660300002)(7416002)(66476007)(36756003)(8936002)(66556008)(54906003)(41300700001)(66946007)(64756008)(66446008)(8676002)(4326008)(76116006)(6916009)(33656002)(316002)(86362001)(478600001)(71200400001)(6486002)(122000001)(38100700002)(6506007)(53546011)(6512007)(186003)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ucfBDVw+kumRAOtoXNdv0rg7dMPrrf4du7aGNXFHI4ON6l4ej9RFxh5U5zAV?=
 =?us-ascii?Q?oZl9jJlgYhn5fLTyK7JzwwWdq+Imtlo1xHTN20QaL0PCpBXqPKJUy1s2G1MF?=
 =?us-ascii?Q?czSxBZXrW5itaHZZ697vWXE9MT4zT/FA/cW6qUh0GniprI6GR/k7g65vieoX?=
 =?us-ascii?Q?Vu4VmiHR+7xpBxjkfB/0MX0ab4UCGviwFpUUUIJzMsbqk+wL3hgA4h40XzF6?=
 =?us-ascii?Q?+MvYAXUuQu5uUXMSUSttCp4FXHpN8olRBHGwf83tI+NJ10Yrz/zPo0lq1BOJ?=
 =?us-ascii?Q?aIs5Ln9sdmB4YJnFTssvlB7xtFjpAxS4GPIW8b4+91UQOC4K7hCK1O7ega9H?=
 =?us-ascii?Q?gKaIj6oFBSC8l9D19tNZ+unPrg8MMlwSDYwzvLjqHNdER9M3xRO2pBusVUP4?=
 =?us-ascii?Q?ReFPqb33Mnq86wdyZEQveXliQneQeFr/jv79y8YfUg20dQXw6Lz52gvL1hZ/?=
 =?us-ascii?Q?ouPcnKepGNw66Vf6qEvH61Lw7uDuDW+lRMbGXayKbUyrkdVWuzm+eROE5jY4?=
 =?us-ascii?Q?5Ybzg3T0aRfhA/yuLv9aiOj4BTyVNoRAl/oDLbupPVy8H/716AuYH60qfeyJ?=
 =?us-ascii?Q?DiRBoyEuj74KHMZlSoyGiombRv8Spn9edyiPeu2Wi0bZFuKDar5T3kjjcjEz?=
 =?us-ascii?Q?sz5QILRzqBo8a/2anjTG5D4OKEU7wGplHUx7B4FctVP4PPjfFizDAWf+vJ2E?=
 =?us-ascii?Q?P2ijtT+PTVilpPFwqODVLXSIWoufyb4+jd5eHEACvIGSTG8WQ6U9nJ9fuFPT?=
 =?us-ascii?Q?taljhiI0ck+NHMOxwHxHYzvL5ycUkMXXAYj7UsPS7whe95U7f/u5HJtclvlq?=
 =?us-ascii?Q?+2bB42Lnrm6XvxTQM78RypJhsAZoNCHdR1Szux2bgBI2HTX47kSO0w7BCll0?=
 =?us-ascii?Q?DCMRT+KvbKqwfc+wjt2csTbG0ug/0a+fv4YyKtRUqFjM30lnDK9Cw5FWLa4u?=
 =?us-ascii?Q?+FuDPt0BZaViBsUxgXpM/skSXwPTgmhonV1NU6KNrr2M6w8h2i6Nu4USorod?=
 =?us-ascii?Q?6Uz8gi5H15FszstzfXWUMJVPaJ3dFXjHWNT0BvOJJaWD76iGbCPqyCIaiJmo?=
 =?us-ascii?Q?uB2Kgxf6EiYb7uBRHbSeOgOZMpxZ1+t6TP/mXtBgRiuXdVI1Al1nIMdcBeME?=
 =?us-ascii?Q?Jw+ZKzi/+d5dyA8Iq3ImV6EdWmjvO08bO0dC/i9g+9HeWOXzdlaWvNtIyROy?=
 =?us-ascii?Q?bSEdCeuSd8n5xMiToV43WLAPCDnlBPF1rWzK0ofVAmrI7SZ36c/ot38mQplN?=
 =?us-ascii?Q?Wk3lEwtBJ3UPCOKi3mCeqR72dqqGzYT1CMf4RCw/NDnWmyPbjscVVncuKNoy?=
 =?us-ascii?Q?sD/n+9JoTGvv7bwJ/KKp9b7tG9lHI7ogqxRbZr2u8Uc9Jm+S061qwgrm85it?=
 =?us-ascii?Q?BPgYjbmQVsYIBMkD4LDAwav8Y5ZUexa6JyeNS0xDkg3fP21KEVbXohx41bgj?=
 =?us-ascii?Q?kZTdYSHUm0Ytgd+XEwRp2YZY8iaUwEugweVPe8999er0fNbwrsJPhncwH5IG?=
 =?us-ascii?Q?VY5f3MwjolusGhkEKbuEJ6/UDyOch0S8ixFIRHYVt4Ktz054R2AymGviWMoc?=
 =?us-ascii?Q?a6EBsm7EM439Vpy5A8ERBz7z4kN2202oKaB4HTjkQ6ypvLKrerM+iIwdXt/0?=
 =?us-ascii?Q?SElt1EbNUbin4GO1caOLZAz0shrPFWEDu7AL+NkiWSLf?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1DBEDCFFFBF1D84BA2333D056269B8BA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f003dc-fe31-4513-c81f-08db20abb935
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 14:36:52.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JZdNdTaFoGzKKJz5YV4llGqPEAt0xvSRXNlquq7PdqMAflr/rMyTOipTzY7dBrYlvhAG2Jhx6lhbjRDl4XEZhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7486
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 1, 2023, at 7:08 AM, Uladzislau Rezki (Sony) <urezki@gmail.com> wr=
ote:
>=20
> The kvfree_rcu()'s single argument name is deprecated therefore
> rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
> underline that it is for sleepable contexts.
>=20
> Cc: Bryan Tan <bryantan@vmware.com>
> Cc: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>

> ---
> drivers/misc/vmw_vmci/vmci_context.c | 2 +-
> drivers/misc/vmw_vmci/vmci_event.c   | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci=
/vmci_context.c
> index 172696abce31..f22b44827e92 100644
> --- a/drivers/misc/vmw_vmci/vmci_context.c
> +++ b/drivers/misc/vmw_vmci/vmci_context.c
> @@ -687,7 +687,7 @@ int vmci_ctx_remove_notification(u32 context_id, u32 =
remote_cid)
> spin_unlock(&context->lock);
>=20
> if (notifier)
> - kvfree_rcu(notifier);
> + kvfree_rcu_mightsleep(notifier);
>=20
> vmci_ctx_put(context);
>=20
> diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/v=
mci_event.c
> index 2100297c94ad..5d7ac07623c2 100644
> --- a/drivers/misc/vmw_vmci/vmci_event.c
> +++ b/drivers/misc/vmw_vmci/vmci_event.c
> @@ -209,7 +209,7 @@ int vmci_event_unsubscribe(u32 sub_id)
> if (!s)
> return VMCI_ERROR_NOT_FOUND;
>=20
> - kvfree_rcu(s);
> + kvfree_rcu_mightsleep(s);
>=20
> return VMCI_SUCCESS;
> }
> --=20
> 2.30.2
>=20

