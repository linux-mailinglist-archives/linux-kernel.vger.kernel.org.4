Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60156F9CBF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 01:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjEGXfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEGXe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:34:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460CC198D;
        Sun,  7 May 2023 16:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683502495; x=1715038495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+HnqYoXx2aCwQhi6YOoHYKdWL6E9p+8CXsMbB3cXHzs=;
  b=P5mU57mH8Ajkk4HBz2KB71o3nMwmt143TJUyLSFX7IjczVSZ8q7w8+oJ
   l/7DAjSIq2KR/WAq8S2rfFe7MhN9rLV+Ule0Ov7jI71RKSX/VqDk/Qaxg
   sDKISwFelhAs9C79D2+vtR3H7ffL4s6oi+dNPINCoYyE6NI1EH7fHAFLm
   iwsaOj7ZNThdm7ykVIksfbJpopZVhnrfH3SIU+LsScbvcoybphPCv9nIm
   ELPoRFVHlSMjoj3GvO9eSi2I9ZuadclIL0i61iByJlwhDs5WC9MAop21i
   VBNorzH9LU/P12yMAGKFKKDPCoaoz02Wrfqz50BbbQpwek4jEvdFi5EdJ
   g==;
X-IronPort-AV: E=Sophos;i="5.99,257,1677513600"; 
   d="scan'208";a="230132509"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2023 07:34:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6CIAu+dfj7XF9qTpxgfFxL0+EbvI9kaxc9XMuOJB4FOBlQpm2rkwCRS6/OfbpZNxvK+8LhU0xrq7ZHIc7Gzc+UWBSVotTTEwTOgZNiwYFDvGLJXGnSTkIlriP/X4vcwys18z07HZ4NG2BlntSRihJ2yKlnr21EFFA/rdX4PtY68uecAkdJOjjPsiqWMOg3MBiJk3QEKwsLsW/yJ6pCW3euw+B16adrZkVUzeLDg94M9ELM0/HCIZJcZO6VNlHCybFQO19h0XIMxadCgtj4cli3K9Be1s7s9PO5YWuf9Iw922IYQTzamToGGijbTBQrhLUPjvAZ6TASIP3SrMjgfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HnqYoXx2aCwQhi6YOoHYKdWL6E9p+8CXsMbB3cXHzs=;
 b=XMruu93info2IXs2RkRkAZu6b7nmLP8T7pntS2Ekyi+HJi60wUoV5LRzevvXLzlJhPHc5aNBrMGX08zAQ5Vh92r1KBz/fn8UiTm1Puqrej5NPJKi+Ig96peZlaM3Ncx4TB7/WINO//d9AFJosQ+9kEAiaMnpggyngKcz3hqAepMDWgeygCSHSED4MnvxnpDoU+mge67tKL5bj56DBcHvHnQRcvypGHJ9eSAZgVDEjKofLjRPNB7gZJbcpylIw89qmr2I7nvsDfxaeriKjRZAbR/CAYwjrH6qpAYuD/adMcbWccOh4/bQlobPjYjaEom9zKm/9/mS5/UULEbPYS1gFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HnqYoXx2aCwQhi6YOoHYKdWL6E9p+8CXsMbB3cXHzs=;
 b=O99/zFwdaoZQRsI7wWFL8946tWbMX828O+t0yPikbej18NLXWXl6fvasiztaHfImzbJ5KcEg8uhMNY3fau9Vi6/1QeLLVDXxdqLamxKhE0yNwyZSasAb376SNG8xQsW9gjpq3D78IcneagBnnYnnYmTaKzgBBg/8qGKwM2itgq0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7348.namprd04.prod.outlook.com (2603:10b6:303:64::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Sun, 7 May 2023 23:34:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%9]) with mapi id 15.20.6363.032; Sun, 7 May 2023
 23:34:51 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 11/12] nvme/rc: Move discovery generation
 counter code to rc
Thread-Topic: [PATCH blktests v3 11/12] nvme/rc: Move discovery generation
 counter code to rc
Thread-Index: AQHZgTyFD/YYYRDKLEuLLtG7PZkYYw==
Date:   Sun, 7 May 2023 23:34:51 +0000
Message-ID: <4zt5oysmqw72l4xzfja2oer72hryisz6zzbboz7dmhhzfypuwx@yrf2utjkv66b>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-12-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-12-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7348:EE_
x-ms-office365-filtering-correlation-id: 817e07ed-0864-48a4-2622-08db4f53a7b5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AUoafw32NN5RKPF/5+tgE4r9gMLlTQZI5NXtm76KOpKyQFgi5bnePpcWuCXajpMHROpoXLKMaZcTwC8F87VGnSjwYtpJ4cVjsg9oBzONhuH/iJ0NvYgkshiZnMDU67gv8IYnh6ygOXvCfctA/yRev2pEqsQM+dqgZOkAUh9KXDIR0elvSIxliBrKhah3+Hu6nuUPUm6Wt2DhzCxLMlnWxJGad2MvcIT0rNHw3OR3Y0L8gwpZ2LLxiKsXDB6/ECk+SYGz5s2QnenB7apWT3Xx855/rCHBj3ZjV1UDMuHh/WX5LmM9ip1qhnU/WkzIJ+gjjcSC4im3vWPfvyyL0boRDt5k92q4vFDVa1tyayZMI2Ccf6prwlRO2NtlFglJTBstWLXkLV31D9Q+d1W12f6VGFyT+nUAGi70LtR/ermcak8Cz3FbYMPmelX9aNTZ2u+aY492S9DRuf/3CJIe/rAv4zCUmO/CZaXCGpbdY/Py35e80LGBC2iDzFUj6i8B4+Q31dJh5Wq8REQ+FbdB04/F/eNdVxkDPHJBlwZUlTFB++hlRstlqJQPCfti6h6t4Todtbq/4unlStUE5WAimYs0nQefik/ZH0sBYZPPs+KcvBs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(66556008)(66946007)(76116006)(66476007)(91956017)(66446008)(9686003)(38100700002)(38070700005)(86362001)(82960400001)(122000001)(6512007)(6506007)(54906003)(6486002)(71200400001)(26005)(186003)(478600001)(2906002)(4744005)(44832011)(8676002)(8936002)(33716001)(316002)(64756008)(4326008)(6916009)(41300700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GeI6hvtRZf+mpwdAjHjCDkBNsL9JB5fbwqhVJ3PP8I/ZbVaX08PqNz7mOmR6?=
 =?us-ascii?Q?XB+9x0bBu9PzoB/HgNu3Di16UZVRaD4Q5mCUbLyCfE0NBlXuSF7QWTkOWX2f?=
 =?us-ascii?Q?14fZi3U/IsZcMI42NyIcxfPqUFmafqRnz/mD28V7KRs5x5ZLOUUJMGIe1a/P?=
 =?us-ascii?Q?bM3o96hxYbvM7o3oO8YQcjhMnbduHa8KICfMd4l+zC+WyZc/41+nGP8wbro1?=
 =?us-ascii?Q?prF3pQLPYXt3y+c8/zJCKCceX4SDC2qiF/qV2sOvzKSFrC7iSIraDZkpPtXY?=
 =?us-ascii?Q?50rBqRA5YjaQONW1HvEZkXCdlo7ynQ/8EfMz/neEU25DBMuO9iDd6W1xBEIv?=
 =?us-ascii?Q?ZdHjYLKRjfn+Ag4ZVlghJkskHOqQJI4ZQPT3kQD4ZO0G5XF3ZdM0nXozQGoN?=
 =?us-ascii?Q?Hvkw4wQ0UUubSRtfaO2xNQ/A4zLIpp/B9FFkkIcjN34iBTQVIKhlA65I5scs?=
 =?us-ascii?Q?intqbiCDrxXpflsf7SVo3cs7XDOY8Khpfi503A4UlsN8EMPBtud7x2A2RBWD?=
 =?us-ascii?Q?blTKVvUBz7pOAasJVIs90HfW77PeIMQ2JFExvBELBHJ3icosiYRxh2JQ5jrN?=
 =?us-ascii?Q?Ka3PpIpSRBvO6lkRENVMr9eKOx9rAiGZYhhtvQf5+gVXFIF1o1zc5+l2+t6a?=
 =?us-ascii?Q?rKxcVSY8mPZSJwnVJI0Xp/yimWqBIan97V/Q8XHBQxe9rMezaEcHD73bVExz?=
 =?us-ascii?Q?KvqLLZGZ9mVYhfA6xU/y1eD8whmSbsYHkEXkMwLimzPAqeAogcB1/6rHvIql?=
 =?us-ascii?Q?EW6+BYNmqMbziapCCjJd0IUoFuWjTPuXMf/xoIu22oF2epDRbozAVY8sXqG7?=
 =?us-ascii?Q?zENvs4hAoWodjfqi3EUFckmOusAG68xg5h1GB09P6BH8MMDfcMqX/W4rdFjJ?=
 =?us-ascii?Q?AIrV0AzXgJKYBeB1OVbVaIuaYC9usVyPKmFKkkC7yCVerHhfQ9QK8+bdnabW?=
 =?us-ascii?Q?Avds+qJ44ciT/iSfRVE/ajb7JRtOs2vE8y0bZW2ohudinBZ1yWkv6Oq98g/K?=
 =?us-ascii?Q?rrf+k/rOHMdR5KKFBCttCNg2NRv3jwjL5YCKj7BXnXj8PXLWv4Q1Gu2RUj8B?=
 =?us-ascii?Q?22Vq37fGg1uNxzTEa8JbY5SoZlwiizp9jGvHB2XcTLevnjx32RyVcgneWLf2?=
 =?us-ascii?Q?0TmquY6xAsB5kD/4e3RmVCcHxCAgQKKDuGPdHl0DOEmF6pTBiRtRHufjVUMF?=
 =?us-ascii?Q?qy54hsyQxAkO6sG3Y8/SXk+8igwEQ4XXk0r6Vs60aq9jCUfnFMvN/lBHV1fg?=
 =?us-ascii?Q?oSwSeRiBHXbe42DSRLpZ5p4umGFCsDXBDOa95jFdWzRw8TUfJ0BcVFUJtJih?=
 =?us-ascii?Q?vphb6X1Nl0Dtk9DXhxZZkl+jLAEtg0VyqO3uvh3/lLqaSES/HKCQilhgw+Js?=
 =?us-ascii?Q?T+eY3lYE6pPyIN4CjI2B0dUGaUzoJVCdlXXXRXNSu2tGtHkmtj7QKEMRoMjT?=
 =?us-ascii?Q?/DhvbapNXvKhL7lP9olxXmajEhde9BEWxLGuoN2y6HeVvDuPqUb/q9ucYmVg?=
 =?us-ascii?Q?H/fE6nkASwZ7pa3DedsnrJNPnEFuWmslOiCeOiSp+e/k4eZvkzaQMHVSjS5t?=
 =?us-ascii?Q?n7Noce1SRGvQYT201ZEjWkQxXzlJV72eovTOm9klztJ6V5VRj7Ww+11p9gQj?=
 =?us-ascii?Q?mulFL4ZOFit9rJ/OB7zGJyM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B28EC2D15924C141ABEBA3B656330AE3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r+Rmwj4baQW6nCtey1BkCWkwB8V676K2qj+Bu7l5Cz6MMor1wQf4DO9z5pRUO8eIwyk//R+002gK4urjZbEJo65ci9yqPwB+srgzeDgXBhwkH9x10G+e0FegoYnPeqwES/fU7QyFyHJFlRSNCEW6kUryLPUSzQIO5b49Y0t+qnbZNKxzsnvIsjstJp2KskGPPQL0uBtYIa4018WyDPToUpAozueBHmARTTlWk5Ex5eTnZv7CzpKrVUa1FTQeaDs0XYuHsHiyHYF6h1BMcup4ezFwNIaaH8tQJPx15auDMNEve+KjvbWXHTKoRjHmWhoqImYXb0hx7sV+fcUTGJmCGXcExi2foTpU4iV1YhTXtcZiGzRMt+n4UZ2gwaBmY46rLNhOLXjeZ1RUfXcZfbfK0b+t7J6jjHzfWHlaPMQoK13F89jR/tVp2JU+8m6WwHS4JlQf1zGc4cc5vcYctGNFDd7xmrdqoj4GTMPjucfH0G/f+277OoXLmiRKBKy+9cBQR5usl+4gXAwifaLIDZ0aXM7B8iAI+aMSAgqkfGAsBh/j8ZvH0GI05oWZBRLbVkD/+EM3Zca6EG56Q4nl4PJTaGcEAJTQFdjIVrk+FzIgUDUcJPRwr6QQiQ3zEvLswnWHQKoX/mIgJ7SQ8RzFK4EraykPYKbbCNiYL+UKi0wNCNf6Po4wHbTelBJfi85s2LpA2qg8Asy5BVpF0H58yVIVbeNNO+EfaljgTej3f5f4gttYae80tmfY8vrHu/skfv0EwwTAzk/0unysJJm2w7JNIXjYfwhct0JQ8Vv/hHtJ2NJsRnvJLD0bePyyBRBH7MbYbMgp/p1g4IstLdpWe/1Xy3Ym2dJxaLaMMo3pMEoZngm5uSs9uHTWSIMsugIQ1+DrQK1JR5qtwpZibY+QtwHpX5YokRWEW0QjVZnd4DWBUHc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817e07ed-0864-48a4-2622-08db4f53a7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2023 23:34:51.7482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMBuEJ/xFsSOlegW4CZuLfj3JQUpOvnEADZJMNo0ECGitfe6dd1XgbZP5oJOTNwmCQofTCabJW1cSAHghK8mz8PWQeCc4awFFwtowUbGtMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7348
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 03, 2023 / 10:02, Daniel Wagner wrote:
> Move the discovery generation counter code to rc so that we can reuse
> it in 002.

The last #12 patch no longer touches nvme/002, then I'm not so sure this pa=
tch
is valuable. IMO, the lengthy 002.out has the role to check all of the 1000
times discoveries are successful. So it looks the better to keep current
nvme/002 as is.=
