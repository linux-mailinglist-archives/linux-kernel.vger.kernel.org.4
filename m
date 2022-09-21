Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804355BFFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIUOZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiIUOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:25:38 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2136.outbound.protection.outlook.com [40.107.92.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0380493;
        Wed, 21 Sep 2022 07:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRMZh3JXQhLkk56ck4HS5wgtboD8/SLW8isFOosiTQ2Mab6PxtJBQfaeV6wFbex26ZzZoDm1nCiDTbPxsRPQQABf4jXk02Qvjl8zBzRwYp+keAhWz07wLO1dHU8j7Z6Y79Q28mnXbT5uF7t7BFWR5LbyVwe5lX/SZh92BtrVpOA5u258JkoMsHnWe2u7Isrh0lOfbRplKNHAK4+MwLAQcB4ZD35gXRs2lfYQvvAFIabnI5+LeoYRKm5GTaooF6DGq9xjFvKGnhhehxStqAEyGa/48E6RyD/5o/cnU9C7/PXUpBbLUI7IbYFhLi75ruYOIKDzzJE5nLcfJ1H4/DuZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0U+5HK/1mWPU73uj3kVaBH6TptxEEuFfggSMm1j3p4g=;
 b=bEyDIdLiiK84lWSqN9EkMH0jod7OBIMJ4aroZvnt33OE/Ynw7I/+tPsS8dXzG2a1dS2F40wd+p+RCDhfnXGvJCsBC2o9uzjMNDqj+rUXZ/4jyGPqi2/idZu5mh9KdHxVKpZ1EPXjjU7zGKDahppgvC8UcnHt8FnnKFDqOIiwB1WOys23SAl7Nx/ylZcQ61yTdsdMOYQ1sPHIbMDiWsWsJYREjnTSAH5qDsnWsylv2fTKL3GyRm6ELlzIH/o53De/rILkeRWP2M6AWYy2MDfjBs0f70No+kJUNxFtWgoV7P2I4w8Txs1t/UuyDjA+RaLJuFEE2MG9GKjM4/4CZ77Faw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0U+5HK/1mWPU73uj3kVaBH6TptxEEuFfggSMm1j3p4g=;
 b=HvB3qFq47c478gDaURg3ClFrx+R8wZlXlLK+pgxjcrg8y2irByIhb5w6u7iRfqcKfVcTCcENfWaZeO+CMFCPtGaq4V7VohGWIIF9YeSE3rHZaXwFaFIGG6vfFslA88POHLsUb6CyUR8LomsFp0ViL9beSfowXpUozS0LyThlMKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by PH7PR13MB5407.namprd13.prod.outlook.com (2603:10b6:510:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Wed, 21 Sep
 2022 14:25:32 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e198:fd7c:5eb4:89c1]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e198:fd7c:5eb4:89c1%5]) with mapi id 15.20.5654.014; Wed, 21 Sep 2022
 14:25:31 +0000
Date:   Wed, 21 Sep 2022 16:25:25 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        oss-drivers@corigine.com, Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Subject: Re: [PATCH v7] checkpatch: warn for non-standard fixes tag style
Message-ID: <Yyse1XvsdiIJ3dun@oden.dyn.berto.se>
References: <20220914100255.1048460-1-niklas.soderlund@corigine.com>
 <aa858ac592679fdf512debe17e0612c575450860.camel@perches.com>
 <YyLtEza0VhSbflvH@oden.dyn.berto.se>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YyLtEza0VhSbflvH@oden.dyn.berto.se>
X-ClientProxiedBy: GV3P280CA0069.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::30) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|PH7PR13MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1d10f7-fdad-45b7-c5fe-08da9bdd237a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyFgMaUpGsXi4cbZLc2SLo9VQCIKSvzh3A9WaiHPU/N/vb+VQ27659QiOujzOuvejGg/ZXEoJkDNY0gZ09mPbGY4ZCWAWoyCkUKGAw1v7dHfTn0o8caAYRtaErw4D+BUhVKtj1qdRXV1ZYNZjzc1fVPaCH/eCqUX/n7B8UHE9ai1bCiVnzTzaVxuotfrZZFw916gpYdvrUdtNTk+4WwFz23BX+fR73u/1pmmDBFET5og9xwJibsHVIPXuR3pfHPs3TJohkHAoiRetg+Lho9zejw+d/AwPXBTZbzNdzSmIQIWxwDCAA6lPT3zF1gLeXRVJ/gyBru6zitDjtNDifUGPku5LXXi5W/I23r4lX3E5peLEQomsJPNGa8jDu/Ki9t2enKnJHxnNno0q9PssqNn8DMkWlBqHIfO/ECe/KUuzQ8OTnI/kGmPBHtHpGztZvY015k7eJCGp+J72vX/OlK/UwzfS9dqc75zfYrJ3wBNHzJ7yZE008OL8aJL3K9PQ9IHZVQQUv2YIi+52eoDkdos4QzbnGn1cnBLgjnoNnWkJZh5qofH6JZ1Y8+NtAJTHRJIjoKk7NDvpL8wuV0wsmWCy2EYlRH3oD2HaZnd6DYD311D9/Poz5LPbHQgs1GgU8RYft7O7GBSLwonHS4QitNQ08uFzlZylr3kagCkBVRzXTfFv97I4ZmxcldRZOf5TXqt1qcSPj6RhGW+jBv6T7Ov8tttfJ0ZBvD+s3YpphP6C+Em7wRP0PxAGikilBzCcRmWbQLMse+88TKRxoGAdS1cnpcP/RoPCA0+HgZ5R1IjEe2XVv//N70osMZtleQnpZTHNnNBqQvADgZ5HbCgJQmOwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39840400004)(396003)(136003)(346002)(366004)(451199015)(38100700002)(38350700002)(66574015)(83380400001)(2906002)(54906003)(66476007)(66556008)(86362001)(478600001)(107886003)(6666004)(4326008)(66946007)(8676002)(6916009)(966005)(186003)(6486002)(8936002)(5660300002)(53546011)(52116002)(41300700001)(6506007)(26005)(9686003)(6512007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CkBv3IOzz8OH7N74GfX1/7TWlchwexxTmM4P9BOmV1ahr9hm2dVFV9e8Nk?=
 =?iso-8859-1?Q?uo+kVS41TCqN0t7CkTTbjiv195/Rn3t864dg26IMh2Z90FPy/C/f6U+LVQ?=
 =?iso-8859-1?Q?DeQhn9DGar3iK6qewCflkEWSOmIpMUj/kWmdDoDix8Dn8E2n29wgX4yApA?=
 =?iso-8859-1?Q?QjvYuJ36fAIrJRv1fMOYc/8iJSJEgnm8/LIqOBLOxDRvCJDz1o9uFpXxok?=
 =?iso-8859-1?Q?no457TLfRtiAuP3ZoJ/GkMRomoQ/P2NxbVeuxukMfv+VEbzcIv+7JLHjae?=
 =?iso-8859-1?Q?SWMLrVhsgs0XqzgRHAxqBgYSbyn9IakD9jf8auEpM00PODQqN8kv1qDv1K?=
 =?iso-8859-1?Q?xiklOUXVDKau3i5HnurtT1GLHYK3vvty9nPzCIqaUa2a/cbEYkwbomhHZE?=
 =?iso-8859-1?Q?MfPjkV6CwJlr640QHJ8Y0CSWS5MFgvlJ8ditfHVuAhHrLWveLlB0diCXtk?=
 =?iso-8859-1?Q?CZnr2O2Dyz092bSqgx1wUbqdUqeircJk1bsc8fRlJNZHa2LBnbIkB+4XLH?=
 =?iso-8859-1?Q?+CPuQt7WFuE1w4loT+J+lEvK1OUEIQE06pbx6J5xDzgHvvOLCWg0wJ8cjy?=
 =?iso-8859-1?Q?oRO6BueRs7IXMQNzZvqgJBC07KJglWAXTmgtyC73ivgxft+Pybm4ysrVFu?=
 =?iso-8859-1?Q?whXJGdp6Hz6o1AHPoMF523ORX74EAjaZg0K8mz9VRFlivO7E/ippKQ0dpq?=
 =?iso-8859-1?Q?qT1d1ija2+dF9sWFj+uTdlYvgvs7JlLo0ye5NQBixr3POTRLYyKt/8P51G?=
 =?iso-8859-1?Q?TJioWgmLpp/B2Vcx/ARYfl2Q38Nin2IDOqlQUW9qwqqDr7tshTAhs3qKYI?=
 =?iso-8859-1?Q?dDoeCAOuAI6O8pggY9EYnzNRB33ir47OTNYEXg6cmuePz39uLFCLZKHlua?=
 =?iso-8859-1?Q?wa+DkugRW7HStbB0XYZzl2bOWl3HudO9qUB0YuslIqaeIXZSJhx5He9vKA?=
 =?iso-8859-1?Q?RgF6LRPTaPySdS9z/fqury5NVYSWkeMKv1gUapJSwXETNifq6ZPtPlVtuS?=
 =?iso-8859-1?Q?Mo13iro7Vss/9E/NwRfIYAD/AgACTFOBUVAGPfJCjpi795PkoR+3QJX6ct?=
 =?iso-8859-1?Q?3gSQpoBrWdXlvI19xuAmWr3mUbqhgM8JQITVAILieHpJvq1QxFLyz4zusP?=
 =?iso-8859-1?Q?HsOInBsGoFkanlezVMvHBkeAwA4xByMw6iRP52W0sL70dHyPCMhDvs7Wy4?=
 =?iso-8859-1?Q?QwWeJnw0S/oXioP1lkD7gHCsqPM87aHAn59UP8WlELrQy5hGVV7Xtii5GX?=
 =?iso-8859-1?Q?XjK74tY77mSXNxozaXemj05Jz04p2St2g4TRZinKWSiYhG2vRhmqCudOPa?=
 =?iso-8859-1?Q?cN5K33kIZQ+hpIdzPrB2YeV/mnV64x65c7TH8KTzzmHJbv6Rl1TKQLB2M2?=
 =?iso-8859-1?Q?yVPe5VL8BZq3C7KPufL9ggz4EC9MjF7l6wai8E9wOS+2g6Wf9h3IcgAEFm?=
 =?iso-8859-1?Q?9Cgtx5OJS5HsvTypgS7Gx3TVc3nXR/xFxN2YlgT05PHRqffsdXJgz+PCGK?=
 =?iso-8859-1?Q?JDRHbdqRddMlZGMo1lGJXZFlBmh5QhsipMsGKm169zRFMb0qTkimdTQug7?=
 =?iso-8859-1?Q?6Bn+Z1V17HMtRWWYrJA1xosPpGAT+bTSRIiGhgLkzKqpaUvFjgCmx1C5gS?=
 =?iso-8859-1?Q?ntGtoxZcquPxr/0fNmcdU8L0822eV+BEwMUbUbmxsgQgMn1WMi9Q0IYQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1d10f7-fdad-45b7-c5fe-08da9bdd237a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 14:25:31.3078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PD3+yNg+Xao+3Elacey1cnFyA0Mp2xaaGnSP0T7+Bnu0nmWNbwzOAiT3aO1Ke3to3OQgpx7pec9XqzavyI9Vke3DybCFDLkd2cmoew+MrgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5407
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe,

Just wanted to check on my misunderstanding below before posting a v8.

On 2022-09-15 11:15:06 +0200, Niklas Söderlund wrote:
> Hi Joe,
> 
> On 2022-09-14 09:09:25 -0700, Joe Perches wrote:
> > On Wed, 2022-09-14 at 12:02 +0200, Niklas Söderlund wrote:
> > > Add a warning for fixes tags that does not follow community conventions.
> > []
> > > * Changes since v6
> > > - Update first check to make sure that there is a likely SHA1 of some
> > >   minimum length after the fixes line.
> > 
> > https://lore.kernel.org/lkml/2febb7893346b6234983453de7c037536e479bfc.camel@perches.com/
> > 
> > The goal here should be to identify a line that looks like a commit
> > reference.
> > 
> > So find lines that starts with 'fixes' and have a SHA1 commit id as
> > broadly as reasonable.
> > 
> > Did you run the grep pattern and look at the results?
> > 
> > One grep pattern to verify the non canonical fixes format that
> > are mistakenly used is:
> > 
> > $ git log --since=5-years-ago --no-merges --grep='^\s*fixes' -i --format=email -P | \
> >   grep -P -i '^\s*fixes' | \
> >   grep -P -v '^Fixes: [0-9a-f]{12,12}\s*\(".*")'
> > 
> > []
> > 
> > There are many different styles.
> > Parenthesea are sometimes not used.
> 
> I understand this, and I did have a look at it.
> 
> > 
> > > +			if ($line =~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
> > 
> > How about some pattern like
> > 
> > 	/fixes\s*:?\s*(?:commit:?\s*)?[0-9a-f]{5,}/i
> > 
> > or maybe even more broadly:
> > 
> > 	/fixes\b.*\b[0-9a-f]{5,}\b/i
> 
> Maybe I misunderstand your comment, but this is what I do in this patch?
> 
>     if (!$in_header_lines &&
>         $line =~ /^\s*fixes:?\s*(?:commit\s*)?[0-9a-f]{5,}\b/i) {
> 
>         ...
> 
>         if ($line =~ /(\s*fixes:?)\s+([0-9a-f]{5,})\s+($balanced_parens)/i) {
>             ...
>         }
>     }
> 
> This will catch and warn about such tags but not attempt to break out 
> it's components in order to suggest a potentially more correct fix. Is 
> it this second filter you would like me to change?
> 
> -- 
> Kind Regards,
> Niklas Söderlund

-- 
Kind Regards,
Niklas Söderlund
