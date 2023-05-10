Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9586FD7D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjEJHIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjEJHH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:07:59 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2055.outbound.protection.outlook.com [40.107.13.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302C735BC;
        Wed, 10 May 2023 00:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOsx8kPEHNuN68Rq4CBAisy893Np0D0Ng4INu71gKTJPHec2MNpVd/kO0ker6LqKXSfSPcwofdNbSmnkQKEA9qDMKKEXO+oyP4KWWnOIn1G9OcQxfOnn+bda1Y000hiQi7sZ4VrxW36BUpABfMAeMPsKsVEOgl+IeyhpvXHnkiPGniEKuVLek/Ya2a34oW0yNkJJYIqhvf68t/41VCDOXmVRYGoddAyuy5KBr2/yzjn7/G6LBm9uMs14R4NqZ17JSo+4UR4P5NqoUux7qU4Pdfm88m3TL2gkk2LQFBT0eeWvkshIfUQRl3lqH7yXTDbStUPtpyH04Ht3YNIkey8xvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmLDCDwJTmNI9JbuVKKnq4ud77V2LnKobdYKwpvPa0w=;
 b=hylxFUHSRZCGzYHZQVwyuzpZhgPUe4zlpToxp009cCx1OiKG7Vh7xu3t65xa/FLnXsunjX+htMUh5wZBXHaOMvdKlkE8ckUeDbiskA6XJfUu4pKnWVaeSQsJ+B3LBoRKR84Bs2O58C+Q9gp2askxvkJ9NXyH/kdRaJG1lx0OYiiS13v9szifpomprwHr7kp/U4Sa1vB96zRr8vZkyKf+qPFlST4iSD5VlKXsG3+uk2ehI6VVZIF+DT5phU3Rg6vOHzIwlv3tufQlnOrUXmSg+38qq7VirN449FNAVKAj6IALMj5I9gpHOX56ZajZ+TMy+sxjpBK/D6f8bK02I41cKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=santannapisa.it; dmarc=pass action=none
 header.from=santannapisa.it; dkim=pass header.d=santannapisa.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=santannapisa.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmLDCDwJTmNI9JbuVKKnq4ud77V2LnKobdYKwpvPa0w=;
 b=BOw/tGEFvhxH/Xv/gv0cCl5o2aqtjNul+oESxFk3ajETdahShyH94Qwzn9b9ocGy4zb9NCh//xkQRagwuV9wVjs3BjWfUubQgOrNyJPxe/FyDxoOq4+dL/0qRJ4kVGNYLM1/yrNHSIsLtlryxlBSsDGPe9nrc9t2M9OdqKBb2RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=santannapisa.it;
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com (2603:10a6:802:2d::21)
 by GVXPR03MB8353.eurprd03.prod.outlook.com (2603:10a6:150:6d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 07:07:50 +0000
Received: from VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979]) by VI1PR03MB2880.eurprd03.prod.outlook.com
 ([fe80::f649:8c94:52f9:3979%6]) with mapi id 15.20.6387.019; Wed, 10 May 2023
 07:07:50 +0000
Date:   Wed, 10 May 2023 09:07:35 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/deadline: accurate reclaim bandwidth for GRUB
Message-ID: <20230510090735.68f62cd4@nowhere>
In-Reply-To: <CAO7JXPhk5qbz9kmiu9WuXS+gXCt9+X8pP2c37hd9ChByLmXYjA@mail.gmail.com>
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
        <20230509132534.09098acc@luca64>
        <CAO7JXPhrqKWfsp860rRmEenxARi8U2gNMGsOn4m+aKporWwBcg@mail.gmail.com>
        <20230509224829.2fb547fd@nowhere>
        <20230509225417.61d36733@nowhere>
        <CAO7JXPhk5qbz9kmiu9WuXS+gXCt9+X8pP2c37hd9ChByLmXYjA@mail.gmail.com>
Organization: Scuola Superiore Sant'Anna
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DX0P273CA0054.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::19) To VI1PR03MB2880.eurprd03.prod.outlook.com
 (2603:10a6:802:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR03MB2880:EE_|GVXPR03MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: 1526a5cb-1f35-444c-523c-08db512543f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZ0hjDUw0o5jtWqJLEGxNVtRXGeEPxcXSTSsBsv56jr67aJhR+81QfE188CUoYi+VSE9tCQJ13jPBUfPbyDKeuOyMWd/iIAgHNM/cYawoDnbQY0NBVL9CbNhTh387iSZewUGlrlfUbIRjAxRBragqYKZcNN3S+ItGkpDgEYQdp1QoVNa64V9J4HJlDKa+NnV+dWMiTQaYWIkWVmiu7VI/VAPP7H4dxsJLRLdAZgNOIoIGzuj4ZhDmfWSm9avDbBxGuYJpuL4JsNj/AWzM1gAcBUd0YRTenPHad7LeEoUAY/0ZmyKzWXGAsxL8GB2syUQ+P7Ott3zTBb2hE1hfJ5RiePA/Ocfd1U8YMx8S3wur7u6rwXT4PTOP6sS4lu2DWym9pY4zV0dtBNkgh2kNQcrvVjP7nnFMWteOduvcTmKxm+OjS8r84BqqKDBkPfEjc2S9+b2sboKzLBaVTNs0Lo+r3N02xolEyxBAH+K8SU+0lsGS9GN3s80ZgsOm38jNl5N00zeHX12ErCYJTveV6anntYpdAzfnMIZmDrepp0pZzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB2880.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(39850400004)(376002)(396003)(136003)(366004)(451199021)(478600001)(5660300002)(966005)(7416002)(8676002)(8936002)(33716001)(6512007)(38100700002)(53546011)(26005)(186003)(9686003)(6506007)(1076003)(83380400001)(2906002)(316002)(6916009)(66946007)(6486002)(66476007)(66556008)(41320700001)(4326008)(86362001)(6666004)(41300700001)(36916002)(54906003)(786003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2lBK1E3Zzl6bjl4YjFwT1dwbk50RFAxT0hjbXI3MDlmci92V2YvZFVVWWhI?=
 =?utf-8?B?TVNaaUx1TDFWeW1GMlhqaDE1djIzUnVFLzNYT1p6UE9FVW5uS2lpc29kMlJj?=
 =?utf-8?B?NENXTmhmMWlQQVE0bWlQSXZPYjdBUHZHZ0lBNHdOaU5lT2QvVDM1NFdJdExt?=
 =?utf-8?B?bmNjQk1OREYxYlorWmVqUkxmeC9PbmJra2VjemwvR1d1UnAvNXlXOTVUNm8w?=
 =?utf-8?B?TThPbVJtMldHUFkzNlVUK2tHRW9KNXIvTlZxSUNhdXE4NGxOQ25KZDRVbVRB?=
 =?utf-8?B?QUtKZGFkRENncUpjSmZFYUVIQ2I3L0VtUXpxaWo2OW13WFNvbkt3Tk1ySVl6?=
 =?utf-8?B?bG13SFpMemE2SE1vMklBbUtVaDFSdDZ6WHNKeHpqMnBKRUxsdTZlejFyeGJn?=
 =?utf-8?B?ZGZkSHQyRE53MkVTMlphZW5jYktVZW9lb1F5ZDZCNnZtd1VabERzNGQ2Q0lh?=
 =?utf-8?B?TjBBZkE4QjdZNVBVS0RLL0JZT2FrSVEzcXkzYkxiRUl6dm1QMW5NTWJIN2xN?=
 =?utf-8?B?SiszdWd3WnN1N0FIWU0vWEFTdmFlZWtDbGluTXNDREJraTkxMVJsT0swUFBF?=
 =?utf-8?B?Rmx2UmZPSTRJRGFjS3JKMW9PbDc5Rm1HSzRZT0RlUjh5ZEVKd3JPMkdpbWhw?=
 =?utf-8?B?TU1VVDdnM1NrbitDR0xpNXhiSDZqK0hieWNsazE5eXBxam1LZTVHVE91Y3ZQ?=
 =?utf-8?B?cTFKUnVYbWZNV00yblZmenIyeFo4cG1ESG9ld04vdlBqeTBBSHg4TUU3SHRO?=
 =?utf-8?B?RFNKU1VOcG91UGNqVUZxSWpVbHU4eUVBREJ4UmZFR0JhN2JPQ25RQUx0M2VO?=
 =?utf-8?B?alI1eTFzclNxZGViNGNvQmtaZ1ovWkcvMHJhbnMxYnU3UGxyUFFucFI4anBR?=
 =?utf-8?B?a1ZZMk1GN2VBUk55cmZFcldGN3Z0Y1A4NUJNSlVuSHVCR0plbmd2UDBGT0xL?=
 =?utf-8?B?UmpKWGx1UmFhWXZnZjVkdHZldkFqMFJIeFBBWGc2djVyalgzbGpiSkxnd1Fa?=
 =?utf-8?B?a2lHZTlqZDdqOEVLdW9uUnZzNitlSFBpNGVTUHZoLzNSNER1YjlXWXFUN0N5?=
 =?utf-8?B?OTRnTTN4N0JkSFNMYUNFajVUc2lvSjhUdk1lZ2FwNzNLL3hwbmN4QTJzUlNz?=
 =?utf-8?B?bnF0WnJDbjZBOVY0aTMyMHl2VC8rbzgwYzFjeDdJNkVlUExEVzZEQWkyd01Y?=
 =?utf-8?B?eGtuSjN6K21lMXRpaDZLQ2dJK2tpeEtNSm9LQ1RmWjRNWHQyNlJDdVZEZUJ2?=
 =?utf-8?B?YjY5YWdPRHk3OS9LMGtUTVhKcGlwd2J4Y3hJQ3dEalNQMXlTVEdPa2IrNHpn?=
 =?utf-8?B?aFFUMGQ2bWtBcVpjcnpSUG81Nkp5Nmp6cVZqQmtlREZ2R3FpUnV0UmNMMEFp?=
 =?utf-8?B?TnFaRUFoaG5hK0tFY0xZVXFZbGVubTJaZUJySHBLNlNWbEtYb2k4VW9JOUFS?=
 =?utf-8?B?N3h1ckhXMzBYdDFrVGVMd1VZeTdvZW4wWXZjWTlJdkFvRmdMOCsxSFkwbHk2?=
 =?utf-8?B?NTlkcVNLeDhYRk9CcWttNE4xbWhOclJoMGZuTDRKVCtvMWJJek9NcWJhOWFu?=
 =?utf-8?B?UWdEazcybGxUSDdoUDd5RW1ZTDhqU2Vrd1luU3VDRE1CSXJvbVBoWTFPREdQ?=
 =?utf-8?B?WUpNMVEzVzVONmlZOVFNbDNVKzZLeGJWRkVBN1NnNEtaWU1tRU5HR2JGMm1T?=
 =?utf-8?B?QXB3RiswZVl2N0RmNHk1RnFUMERQM3dRenMzQ1dTU0U0SGVSaUo5REZJQldZ?=
 =?utf-8?B?Y0w5NkIvSEgremJtTzRidWxTMVlDZHQzU1R1NGJmWU5jWUtJVUpVRkN0dHF5?=
 =?utf-8?B?TGFvOW9WMVd1N3BlQWtkZUEvbzNBc21lbVpxVkoxaHBZdU1La2lVQnR3T25G?=
 =?utf-8?B?Y0ErditiNVRxQVZPdlJySld3YmtrSHVBQnEzanpKUFBqemdyS09EcksxYXVk?=
 =?utf-8?B?bG1qY3VwMWtmbzNaNTl6MUxrTnBxb0NIY0RyYk14bVpSd2wwVi9seWtZWG5a?=
 =?utf-8?B?bzVtRDZZTE9SRFBKMnhvSVVMVER4dzJOQmltdlYxd1J2UThHdFRPUDg4SWRD?=
 =?utf-8?B?VmE4aWwrS3k3VUpWWG9EWXpxb2tSTFpNYlg0aGlMcUlmSU5TcEdCMDdCcEg5?=
 =?utf-8?B?WDAvZHlJblcrQk5WaUJHU1RpS1JwZVo3UFRQWXA0SHVLMU8rNnU2ZG92TjNY?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: santannapisa.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 1526a5cb-1f35-444c-523c-08db512543f3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB2880.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 07:07:50.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d97360e3-138d-4b5f-956f-a646c364a01e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3jK4isjYIxuYC3ZMFW8LOYCUA+nANH57i4nb00vRCbvq2af5+ALKWK+xJpbqRlplH1UF36HLB+wMaELW5Gz7WOaPrq99r4ENoODamBwtk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB8353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after thinking more about this (and re-reading the code, and your patch
:), I try to comment again:

On Tue, 9 May 2023 23:53:28 -0400
Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:

> On Tue, May 9, 2023 at 4:54=E2=80=AFPM luca abeni
> <luca.abeni@santannapisa.it> wrote:
>=20
> > > Yes, this is the approximation I was mentioning... Instead of
> > > using a division, I approximated it with a different equation
> > > using a sum. =20
> >
> > Sorry, ignore this comment (and the following); I misinterpreted the
> > code (and my old notes).
> >
> > I do not understand why the "max{}" doe not work well, I need to
> > double think about it.
> > =20
> I was thinking more about this and was doing some more digging into
> this. I was also wrong about min{}. Giving it some more thought, I
> think (U/Umax) is indeed the only equation we need and it will take
> care of caping the reclaiming at Umax.

Uhm... I am not sure about this: for 1 single task on 1 CPU, yes,
u/Umax does the right thing. But when there are multiple tasks on the
CPU, I think it can cause issues (because every task ends up trying to
execute for Umax).

The "max{}" comes from the original multi-processor GRUB algorithm:
https://arxiv.org/pdf/1512.01984.pdf (see Equation (13) - in that
equation, the part we call u_extra is included in Uinact[p])

the "1 - u_inact - u_extra" part is needed to make sure that the
real-time guarantees are not broken by the reclaiming mechanism... But
it can end up with a task trying to consume too much time on a single
CPU, hence the "u/Umax" term in the "max{}" is needed to make sure that
a task will not consume more than Umax of a CPU.

Now, if we have one single task on a CPU u/Umax will always be larger
than the other term... But when we have multiple tasks the other term
is needed too.


> The reason why it was not
> working is because of the loss of precision when we did the inverse.

I agree


> I tried replacing (delta * running_bw * bw_ratio) by
> div64_u64(delta * running_bw, Umax) and it worked as expected and
> reclaimed only till Umax with only SCHED_FLAG_RECLAIM tasks. As an
> example a task with reservation (1, 100) and RT capacity 95%, and
> delta =3D 4ms, we get scaled_delta as
> delta * running_bw * bw_ratio ~=3D .040000 (roughly)
> div64_u64(delta * running_bw, Umax) ~=3D .04210526 (roughly)
>=20
> This caused the inverse logic to consume ~99% bw, while the other
> one consumed ~95% as expected.
>=20
> I still could not figure out why min{} works. As you mentioned in
> the previous thread, its the loss of precision thats the culprit and
> I think we only need U/Umax if we have enough precision. This along
> with accounting for both type of tasks will be the solution.

I agree with this.


(BTW, when considering multiple tasks on multiple CPUs, another
potential problem is given by u_extra... Now that I remember all the
details, u_extra is not "Umax - this_bw" - this is true when we consider
only one CPU, but is is "Umax - sum(u_i)/m" (where "sum(u_i)" is the
sum of the bandwidths of all the SCHED_DEADLINE tasks in the root
domain, and "m" is the number of CPUs in the root domain)... So, the
reclaimable CPU time is distributed uniformly on all the CPUs and this
could create some issues. But let's see what happens after the div64
fix and the SCHED_FLAG_RECLAIM fix)


			Thanks,
				Luca

>=20
> I will look deeper into any performance issues with using div64_u64
> over multiplication and shall let you know soon.
>=20
> Thanks,
> Vineeth

