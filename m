Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FCE74CADE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGJDwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGJDwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:52:42 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9BFD2;
        Sun,  9 Jul 2023 20:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688961161; x=1720497161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u4hMXxoSwRvkG3YIhoeqfmqYwNRqmHcw0bbkA1tj9Xg=;
  b=UDW1VWqXWcQYyJA7q6TIIq8WTUN78F9miU8LQ+BszVumuiLQcaC12s7G
   w5nfuxZB7lc5BC+Q59/WcWo/dpAJryGzAe+XjXxOiASlT71/jA3RoHChg
   gt8DVrx5bAcJ4KilBVVNTp936+vY9SIrkEIekgVlImhMJbyRNPBqUWtLY
   SG0t/xvyMxgSZMnKObg2digqrTwl5HDI4xFvBRbrttW3QrTvqm48jJHIH
   4kUe5DsSs0RK6KvMzUCBr7rFoM4XAK/uI+7dTBwyhjkc9JXNZT2bRrNh5
   Lno07E/h0k6EdJGS9lZ4VD/T/axf/+uJXhmdAyYP5Qztzicf1dwrOBOXo
   A==;
X-IronPort-AV: E=Sophos;i="6.01,194,1684771200"; 
   d="scan'208";a="342656398"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2023 11:52:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc1bU/iit7+MG6wPzVk88tPiMlDBFqkMTpcMqk2/R1vky1g7eljfRJBX4qIIyNJzzcNjI4J7/rdXI5tO45Zyp4dd6ccpDQtf+lN2TzfMmJmWkTJa623K8BbB7wqaxMdXrxKDEpTzdGcGYOlXJBRDtHXDhD2F3EXiVXmqAr7fdZSeyY9Kdni8lx68oWIEpVhBSEGHL7+Fud2+52nWNNlii+G0P8vrck9+ot0YuClnLqXHDsvyoS5iSAicN/2vArxW7qY3gl68xpzfAprcuME/lhQe+dWsrM2P2jOjhCS2wp9ZalmGXSzFcmxFxNa7zknGfUdD05w5O4ImQr4WKvDSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4hMXxoSwRvkG3YIhoeqfmqYwNRqmHcw0bbkA1tj9Xg=;
 b=IGsTD2eJcjkwmORxHxibHMvLx22hp91l9te1Q+ObEq0HuFgPHyo47ZvIQhL879ZVJBtYRHhXgaHUnwGnViYuByDzefoSwwmLZB51MdVTYSIL1+qv9BNnQ7iSz1Oos8XkZH1RgO7VOcDzwy7K46B4nXEo6ZKBjlg+uVZcxNtqhgtshfUUYfcO5qeGWfuGuXJLu1fG+zb9yMNlG4wpj41oKhMxct0/UDMCjq1WCOLUUjbN26mXvk02p204b5208U2GE1ygZpMRe47bbigPAAQIurwWUmGoM7UovcEoyK+1TtTRFGtZO0seziUUin0Yp+yOFYpaTuirw0w3USthbJ/xBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4hMXxoSwRvkG3YIhoeqfmqYwNRqmHcw0bbkA1tj9Xg=;
 b=tv7lAHEv/xRGUH0D39PawQShTm9aq59tNCRi52mlUYt2ce31xWPoFAGzvMttzGvb11cNNkiBUYx94cskOn3SDOrYuXT6bkpx/psUunWT5xztH6j9vVafZ/NIp/S6sO7Z3gCxGObGHshSicszVhQ81Iznw8b7N0CExcjauWJOv3A=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8454.namprd04.prod.outlook.com (2603:10b6:510:2b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 03:52:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 03:52:37 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     Daniel Wagner <dwagner@suse.de>, Yi Zhang <yi.zhang@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v3 0/3] More fixes for FC enabling
Thread-Topic: [PATCH blktests v3 0/3] More fixes for FC enabling
Thread-Index: AQHZrY8fVxswUZuTK0qCaSHq9WkXZq+pMZkAgAMf3gCABhdYAA==
Date:   Mon, 10 Jul 2023 03:52:37 +0000
Message-ID: <gh6q6aq5sdh4elap2zisccrwrxtf5bnh6yerv44osc4tjy5qum@6vd2yvqhdf6a>
References: <20230703091647.800-1-dwagner@suse.de>
 <op7hkwiauywfosn4q4h3cihdzcoy4m4vqthanv4urwxo4trazy@2qtljklkt4ry>
 <9125301c-61e0-96e4-35be-94d9c9565e90@nvidia.com>
In-Reply-To: <9125301c-61e0-96e4-35be-94d9c9565e90@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8454:EE_
x-ms-office365-filtering-correlation-id: a1a713ca-585d-40f3-e80a-08db80f919d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2EkoekGrKR2ObTVt6yijyG4tl8LidQ0WOcCumi5aqNkbmHhppaNdgou5qWX98eDceL8/1rQlsh+R5HVJ4oWIhR6wWzxOhlXv46OqzBMghOohA/Iclj3L/pSyVgPSrNCgX27CfN/6P/UbBGhI12kDF8qA8Bnk6ji/d4nc9W/h5EMu4+mIG7wZZsRm/tqXhyxxxs2PSjBlgps6bFKI17aXz5Ehw1FduFcMj21SPcf6+tlF1gUEVtpNEqmx/DqNxKgexufpdR6ZpzyH19yKNRRKOh0FnPMW97qkRVzVyj1Ef5Fd5pZ9TiFAyRhD7xLgb9Ow9qiu2fPd91DZWmPgi4H93D8g8X4wZtqRG7mUsfRUz/p9AWi+f7VkPcmCcMsPYkPaUtqJfoEvHDB/ybkbf4yopy/7GUKkJ7Imk6QSdCkIb6Q98e3wSw7tsIZVYXPp9B1YrSchUb/0unNgjyIx6Rtyd+YDe9jRwXxgB1XLH5bEClCJyHc2xdBcumYeawzGqw4Ym/dkv+j/y9dZhs8w0lZtMi1Qi7e47c/8RQkw+tJw0HvcDJSTzzhoXcJN+KCDpsXclEEghOS20zyd22UON4vzmC6SHjzSyc6ahIkKbkTFSvk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(6486002)(478600001)(76116006)(71200400001)(91956017)(54906003)(6506007)(26005)(53546011)(9686003)(6512007)(966005)(186003)(66946007)(2906002)(33716001)(66556008)(41300700001)(66476007)(6916009)(4326008)(66446008)(316002)(5660300002)(44832011)(7416002)(8936002)(8676002)(64756008)(38100700002)(122000001)(82960400001)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vl4EBQWjbswyDGWzHpwgOzXanGZh/hnFzoWJHCE5pQ7El9XsLpqCa/kA/Kg4?=
 =?us-ascii?Q?w1tbauSaKg8xFyYy0EXLS9J0n19xptarZReBTrEU6MEulSyK9WvTTcpdJViR?=
 =?us-ascii?Q?vS5LU1tweQi/NFEZcmdGEflNqK1tuIzgvdP1GiYzpk3QdJvuk3QDTje1w354?=
 =?us-ascii?Q?Uyu1iYwf/MetO0VOfU7Wr1nwvZvvZ1wMx0RVRu7SNeLIcKkxqrew6zxLKuuB?=
 =?us-ascii?Q?C5VxRZP99tiVUaXqKYGF5vU9tSfKDkFfporY/BPA7le5NFUlQsRrWtql8A5c?=
 =?us-ascii?Q?Vn7yqBn+nvSJipCFmEGP8suYy+vPIJVxqENB1F4rs1CUvErRPLVUTcwS5dcy?=
 =?us-ascii?Q?IEUtV79m9fYR9iDq8+uifRH+aWcJiWHlAYe29fQsDhmKcqJpv+ybgKS7B6/o?=
 =?us-ascii?Q?r/ziRUGAQXkaJ3a40u+LVzygT67yOGcUzPcbQEu0gzpGyl0T9ScLXSrxAIf9?=
 =?us-ascii?Q?MHLopP8fVBcIFesvEO3yIXJSwKpiS25ZkvhS0V+pfY26FhHl0uM2mr3lQXWT?=
 =?us-ascii?Q?biwWGUZK9OshE/DSuVwCXahu06aaD0QOoXLQUA9dTUfyW6lwixO3+LqSsb8y?=
 =?us-ascii?Q?Z1HAR70gXBpjCmlcf69+/0KJk4OP4yVU7dig91FFce4DuwksnEaB5+kCM1Wu?=
 =?us-ascii?Q?0PRMR57Izd4HOTCIQn2sCwumA26tMLXTdtR3Cmuq2WW/z/9Z2YZf/URBaviF?=
 =?us-ascii?Q?oyy3Ff8KT1A/XhEUlK9+bAI1IiNhrK5iQzcyNqVd8boZz45sE0MU/4HvwAMf?=
 =?us-ascii?Q?Pummpu0tVMcBXdK9LbBpaXbNBHey4yROsFsoZP0v3mUJqYCgKUffMLhhXNHu?=
 =?us-ascii?Q?i8GmqE9OA9tRn3AbC3UfuD2CPApg+OOm7mbKBZnWID1z6DU0mRXW9Elt68u5?=
 =?us-ascii?Q?liRJD0CeIhgVGH0dC3SlMyaFXypK2PqBZFUdslOCA/enjMc1vDQr0/BcV0OY?=
 =?us-ascii?Q?uWdkPL/us4vHKuxi1wFN/e1QhS+a1nlX+qKjLt1C+Q2vmyzmphbVFaPEKAGw?=
 =?us-ascii?Q?3ZW6JmPRzcda9Gb5ovp5o3kN+SrtnQmNUwDaGtXZzvlEyXA9NG7lIOyGTtgT?=
 =?us-ascii?Q?RIns7xEWIHhPrOzR+QdY7G9WN8YyfSBh61kdc3xMHtbnX7S0lKZIy3FHkNQE?=
 =?us-ascii?Q?zgXtb5D0macwvnRhgdz2XE3YGFwKmHesYMXhLILOkbkQPEIjC8xZ0KAovBDv?=
 =?us-ascii?Q?RFmMyIV1fol+YpIFuIjnJkex/X1HsPxDVRlngUxCRFItcmBZ03v1+mnU1avG?=
 =?us-ascii?Q?a4iT+tY3CTJAPt8jykAsVKxvhpwnmW0YlzAcexk5ux5QYynfGk+xyxw0i3gG?=
 =?us-ascii?Q?AxQqS0z1TcEO2jxmLZ3CGlKwnUE/sqoTPDvyQsxhrw/y4Afpqnfl5qlv6m8I?=
 =?us-ascii?Q?4p5AD49TWNb3YRmIDhkMEbpTKSxwjq4j2AVzo7oK9VH9piLlSvKJDs9uuwCX?=
 =?us-ascii?Q?fWO0npqLmE+02tiPENvbIXH0C0PLerKhK4exQ1Ru8l8bc9KTRF0EyoxsJwui?=
 =?us-ascii?Q?qbNjS58prvOZ0vn5eO7YTkMMcM1mgP7E6EgRleYrhmaJqOSmYq0XJz4h3bQR?=
 =?us-ascii?Q?88k12E80y7auFP6CaPGKem8FYxdAv0glAnuPIHxIRFUgNBpGgtwDYd9xnBzZ?=
 =?us-ascii?Q?2BXgucVLBikrPlwb17jgyZI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10F513A4A9180C43A139217A1E3EB796@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6fY48ZhZlfYQyHY1cAf4Yp4az0GaxdTOKSFRyQb+1jAo7kNOCcpfP40JyHp8?=
 =?us-ascii?Q?iX2dKs/9JTCT6gWiKLED0810ZD9QTS7IG59162RoR27XRH63F7Qy+w9xuPKT?=
 =?us-ascii?Q?mGIL3z+L9e6fMmeWPoybVqnH9IiW66WW4r55whUPwXZBienrkUE99fLdNvzE?=
 =?us-ascii?Q?6SawSNWgjfFYZufqmz1en3vU/vS5xYBgv9ydt7i1lO06iKf9g6yR8DSEI2pL?=
 =?us-ascii?Q?xEdmx8yiIraehl63F/WdNclTTt/RIuREPoD/LI3McdewDo3BcXp7MbYriq0E?=
 =?us-ascii?Q?IQ3hJZmJ4ruLxeq/hIEo7TuvI3n7lqXVsOxymHTGsh+biWSHON6jZHMzAfJ7?=
 =?us-ascii?Q?gy4vXRi8Bu+5f/+Sjl4jzSy91hcd/3FtqRkGmcjPn4duvulXtVDzsk854pQ9?=
 =?us-ascii?Q?qbqozZ371mYUAqkz+FsmHUsxXhrrmNp0rRRqRpSqgAAK30uuNnwU4rs+pYIg?=
 =?us-ascii?Q?ZJc5HYrsWaN+clF6i4kwk2Egkzj5s1Q30Pu+Vcdhx8wgtTeZ492PwPvN4hp1?=
 =?us-ascii?Q?0vTnBToPY0O3Z6usB346kX8ow2yEWvw8FoK8JnLU8WeQTN/b4OwC4Ai1Lo8B?=
 =?us-ascii?Q?deLIK9YXPOVAOwEongEM6TxJ4D2SgbERm9qfSItiww+uamxfAZyReAdTPGjT?=
 =?us-ascii?Q?zDpGa0VOq2SRquJgduuU9fwdjg1SUdEs44XM/O9q0VSQreP6rzaN1fUv1vHH?=
 =?us-ascii?Q?XTq/6SE5Ewp+aRr7d+b5CQ97gcM1fGNEtM5FKdWypJANKR+nYMcEj8vja185?=
 =?us-ascii?Q?Yi8ne6jZcgn02eeplGGlalZhQ8mMvRht+/5gvOerTPJvreL0n2Z3hqXHbpJ5?=
 =?us-ascii?Q?v64gwsI/bcSfmm1JFD+2ORPPyV4XcVSVVv6C8Ghy171VmbONgDl7thoorAwS?=
 =?us-ascii?Q?oIDTpCZuTBd0RJWg3Ka01T33CvC+YLAMUM2DibvtHN+I8J9idn7OQXbWidsE?=
 =?us-ascii?Q?FmHdOQ8skGR7hh6yfxf7XTCi7UCrjhj+yGfy+YDgmQs=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a713ca-585d-40f3-e80a-08db80f919d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 03:52:37.1285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRh/rPFGpIT50ERrODoo6qY82nkmyOdjgBue/fzR/OSVgxsNMXVzWXpZmDvUEI6gtD4IYWMR2OoqoiYtqzscNYhnxVJ+shKoFVi0gblOPqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8454
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 06, 2023 / 06:51, Chaitanya Kulkarni wrote:
>=20
> On 7/4/2023 12:08 AM, Shinichiro Kawasaki wrote:
> > On Jul 03, 2023 / 11:16, Daniel Wagner wrote:
> >> I've rebased the series on the current HEAD and moved the def_hostnqn =
bits from
> >> the second patch to the third. This should make it more consistent in =
commit
> >> history.
> >>
> >> Also retested and found a bug in the context matching code in libnvme =
which I
> >> post a fix too.
> >=20
> > Thanks Daniel.
> >=20
> > One thing I noticed is that now the 3rd patch removes the references fr=
om
> > nvme/rc to /etc/nvme/hostid and /etc/nvme/hostnqn. I'm ok with this cha=
nge since
> > I see the motivation discussed here [1]. I will wait for several days t=
o make
> > sure it's ok for others. In case anyone relies on those files to set up=
 blktests
> > environment, please speak up.
> >=20
> > [1] https://lore.kernel.org/linux-nvme/ajcm6yupguickaucansiuzjqatyz5qij=
nnp4topxv64cisbblc@4sgv3bd3jl4q/
> >=20
> > Other that, changes in v3 looks good to me. If there is no voice, I'll =
apply
> > the patches as they are.
>=20
> Adding Max and Yi who were part of original discussion [1].

I saw no response to this v3 series, so I've applied it. Of note is that I
resolved a simple conflict of the 3rd patch and added a note about /etc/nvm=
e/*
in its commit message. Daniel, thanks for this work.

However, after this action, I noticed that Max made a question in the e-mai=
l
thread of the v1 series. I might have been going too fast. I hope Daniel ca=
n
answer that question.=
