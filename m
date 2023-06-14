Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6DA72F7BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbjFNIZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243367AbjFNIZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:25:24 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2122.outbound.protection.outlook.com [40.107.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8A8CA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:25:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beY5hsyK9GaaTa2VCJn4XCiVPTXDyGwx65rBTb0TK+T5vYLqSesQA00mRJTK7c7H3a/SbZYRigoSb/LqmGqQ9xsYBYqbuSDWOYm7QNUxzdBGaBbPE70CoXqxUnOO3X0+cS0JEmzIZfW2DN/Uh4Se9YpFLWKum6ItRz6PfbNXE8DX2MYfujcN0O0lEU2ISuBd7dCUl1zfNLuXmgRDxt8amuHBgJfl1LpOfww0/phihdiD5JaEZo+UtRbLnfq9CuZnMQvH3cjFXO8VU5Noikt5TmBdcZOuKNEd0wMQULZEg7SdTCx3JNR5+uA8REbfoD4o3RcnAohzD9SB0nTwxa/eBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sn0Jg/+pZ3tt3mvzAK7jt+5sbwbLUAY4OVqtNQM6n4o=;
 b=ibHbrwqAnOqqM/i+3hNDIRqpeI9beGbO5lG+p1qdjPEjbzqRvKTyJoTPQE7srmzZB0sVIbf0JqINGn2da4pdP5gf2Dj+rvFxI83l3eecUjBUAZljp8pEyu5r2DkU8wIumfThhXLu5uHA2kZ546nNOpBioQ5n3v5DFKeFhMc75C2Ek6p4s8pQ/i1MAVT81ZsSv52cwCWNQxmcatbaikyDd4/AQVXcZsuOz4isGC38xgGWT+NOJJ7di488qJ8Ekui/3RO9fkDc7vOayEFMnUFFbPQMSyPq/TcJvlYK2Ke6hlmyUlAFBauFZjfPEgBdsIl70qhPwDtnyihvNVWMT4EX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sn0Jg/+pZ3tt3mvzAK7jt+5sbwbLUAY4OVqtNQM6n4o=;
 b=XAePpfQ3/z44nVV0x4LYQ5Q9M8k8zs3jlSFjZ8Cjb1F66DMd2Y/XUgbgTyXTcJVcqaIKRUhudt0ewzMkDvUx6TgSbXL39pc/VYGwAUkT/8MDmiRXScRRDSzYnqN2AvMGTEdahz1x2XXK/MEoMv/Ea1nheY/c0ScPBzx+rmPk+tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA3PR01MB8524.prod.exchangelabs.com (2603:10b6:806:3a1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.37; Wed, 14 Jun 2023 08:25:19 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%6]) with mapi id 15.20.6455.037; Wed, 14 Jun 2023
 08:25:19 +0000
Date:   Wed, 14 Jun 2023 01:25:14 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
cc:     will@kernel.org, mark.rutland@arm.com,
        ilkka@os.amperecomputing.com, john.g.garry@oracle.com,
        renyu.zj@linux.alibaba.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf/arm-cmn: Add sysfs identifier
In-Reply-To: <b8a14c14fcdf028939ebf57849863e8ae01743de.1686588640.git.robin.murphy@arm.com>
Message-ID: <7b93e04a-c51a-cf94-8326-446c5f488a3a@os.amperecomputing.com>
References: <cover.1686588640.git.robin.murphy@arm.com> <b8a14c14fcdf028939ebf57849863e8ae01743de.1686588640.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0PR03CA0439.namprd03.prod.outlook.com
 (2603:10b6:610:10e::8) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA3PR01MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e909eb-92de-4d98-91dc-08db6cb0e3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXPedAciDX1aUndlSCsclPUQXnHJlHRZEvfhnKf9wSQuJloJXpftils2HwZe4Wf4I3oRd5b0LfS6cnKTVzhPgLiLeA6F7UhAThK+9H0R37/1cu5vJkhW1cA/mw27lNtLjJcEsec+LAspRuRlUoIc06yyShXNiFX1vPX/T6+tz4D43Jqh87eAuxq+0/JdqBGJgqauKuJRyAbOHwFx3h7JLM/r+whxUab8cQp/0tXO+WT/wyjNJOS9ZDQSdp0wxJ2+57Whnd+0W8j46SvWG0BwSLCKi4PVlCthPrtJQIYE8thdFt3gmsYT/QzS89ZH1BqC8ZOQLd1UUnWLJyqEHcsW2jITlb7zlHShzBqhjda9PoWArtdzWzk774iFUu3W2Z26bDM2jZDhl3xCA2zhe3cQDM1+qHZmFnjIkeaa6Xy3YV+1QHNLdWxcJ3W2JfachG/LFdG9dMIWJy1NHw/TvG3F2prKThQ/KfoIqLblAjLoYdSbbbnPGVdj5FK6snWCCfKtWrGS4UvIOzj/JeHYqqCBdpLTGAiifmqCZkH5WdLISRIUrtZOA+cL/mMGlnrooTS6PP6nqwurelEtH4u3SheVsf7VAvjosxYLyXmm1jWTH3opB4Uvg8DlRWGCJZyeloNT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(83380400001)(5660300002)(186003)(6506007)(2906002)(31686004)(2616005)(41300700001)(6512007)(8936002)(52116002)(26005)(8676002)(6486002)(316002)(31696002)(6666004)(478600001)(38350700002)(38100700002)(86362001)(4326008)(66476007)(66556008)(66946007)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0lw5TfjPLzfSb7E0uQFFAIXmNQxJp58hq2PuEsFPCQLJIdtUIAPWxQvd+1u6?=
 =?us-ascii?Q?gt+nH/PAhewWe1gjyQbyin1zY8LTnTC3p0veuX6I/gqoGm9OSSv6UwqcJdXe?=
 =?us-ascii?Q?mzbwkFuIzQyp+tSAGvf9DGm2mScHC5eP3wU1a1nBdhdla29jd0v8IzzL++jl?=
 =?us-ascii?Q?BZJn63ySJI09IzdqhxvfHCpS4C6Y5lHgMfzHD0IS/JqMHA+Enq0TAa+WIXeL?=
 =?us-ascii?Q?4l+NQ1K0eEXuMr9Sm6bk48d4Z/VE5VUIinMyLnroo3iOrMwo6jvyQCKuZbqC?=
 =?us-ascii?Q?Ep/NF5QD/E2+az78xUDGwO3h+0PKPWeHh3e8qsw5/KxttFkzBUAw7gNhmMqm?=
 =?us-ascii?Q?sHPjZXo/8BOAHeikZ3v2ySIxSi728X62Wh3MbrBJNGhGg192oo6SeLfwSOZ2?=
 =?us-ascii?Q?2MSLCIeamAlHNNpObyvpy7APJ3IAqJl7Twibh02zrjT2sYuy3Etl3BFjqBP2?=
 =?us-ascii?Q?yOdsPfLuaaCWRnesLIpcv29buEPi8j/CJlk5lse8e5EMBkNpjLbbSJurxSj/?=
 =?us-ascii?Q?Zxikl0dFzQcnTFfC+xgwJV6Ego2x7QaHlFu5/7D+shvTnVvK9IPh9lBXL217?=
 =?us-ascii?Q?1rZL760D07zHJw6FF7UwUjdVL49aNgbPXpqXD/erQQU1aFI8C6CA7+5CQN84?=
 =?us-ascii?Q?S/0i97fnuyZc+M7UD5MAEAkRr+SdgNfCizlNk9XnVR0x5dqxSLjhg2Frp6Ed?=
 =?us-ascii?Q?VK6aQEzgWOe0oRiv6F9+5k8dQwLxfeTPvC7mArtQkL5BkzvS5S28CJtUXKV+?=
 =?us-ascii?Q?2Td30o2F8psgDuv7TeTH9yLoJmnoDF27stIyoOLLHNoc9W23CboE5t3CZvAp?=
 =?us-ascii?Q?RKFRt3xwI+Rt49xo9UJyDxPwDdrQ+2bXxosK8ehLR6dtm0iBMn4ixBEpI9mC?=
 =?us-ascii?Q?uJze3UcOdVI4mddTFIYBHHbph0daOj2ikVsGkOUADMHsOGISIVCe2N3YSlKu?=
 =?us-ascii?Q?XpIhmoqjMdyujyZ7NWfjVzktSNQxwPzvQu0SPTctvvwhUdhfCE3v5XzYFpBs?=
 =?us-ascii?Q?0GzLOnNmUeXlV2QTXhI8C2T51HZW1BhpvP5CoiNSNNBCJJs1/HzZjgAS4I6z?=
 =?us-ascii?Q?Yiocuf/9XUceVI9443+QNRZwvtvTj6STS3H9GJ9rjSkyzA7bEO0dXodzaKvQ?=
 =?us-ascii?Q?/5V5rgWe7joh7QwZlsEOJtCtEnZwOuRll64GnS+K1xczgQRJnU+PLCKvVbPK?=
 =?us-ascii?Q?ILG33yBbbWkVus7Rc5PiLv8RvmcZk6B3CIKbsWIDhsIO3PNVW2fjKrrSlTCr?=
 =?us-ascii?Q?hMwlIrwIpDBdw0lpDQjhz3LM8HNNyxoG9Z1uZEQHVtgFavnHj3fSEIuU9bTe?=
 =?us-ascii?Q?LAX/9wFWu077RMufMWtS79nZ5b7ZO1nxbhQJiNgqCxrvBVJhLKgbUCnug1wv?=
 =?us-ascii?Q?BMx/fDEssA6jADGKgPw2u7thNcPNK6cb5DpD0y/nSlpG0vHcpqiP7gXYb+pa?=
 =?us-ascii?Q?cYa+hMYotkWcEN4O5pIbLQZHM2PR+1icMbcospSJEzx2lZia+7uvWl88ixXm?=
 =?us-ascii?Q?Un6aIAZUcmB7K9C+d+p2QVHmj7qxplw18+QJc4sMqcbVnPLMfEBt2JRIL3PC?=
 =?us-ascii?Q?Y5peTk85x24CAkHogj5Dljcsm4HNl/aNMBSNvmhdXAn2pGcwZ5/midc+akZN?=
 =?us-ascii?Q?w+OysN6Z7dM97bv21wF67fg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e909eb-92de-4d98-91dc-08db6cb0e3ee
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 08:25:19.8523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hfumZ5SoV79pnoyksKIhdWzkqT/WAtyAY0Z24fVfFK+v9gCP3Q1v0iakZyn00Usozpo6/c75gtaP/8MVy2t0DLhM0s4GNO0HswnLCiFGLsTRvBVeZxRVq73PH6sAs3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8524
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Jun 2023, Robin Murphy wrote:
> Expose a sysfs identifier encapsulating the CMN part number and revision
> so that jevents can narrow down a fundamental set of possible events for
> calculating metrics. Configuration-dependent aspects - such as whether a
> given node type is present, and/or a given node ID is valid - are still
> not covered, and in general it's hard to see how userspace could handle
> them, so we won't be removing any data or validation logic from the
> driver any time soon, but at least it's a step in a useful direction.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>


> ---
> drivers/perf/arm-cmn.c | 20 ++++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 8cf4ed932950..088dc5c690a4 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1199,19 +1199,31 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
> static struct device_attribute arm_cmn_cpumask_attr =
> 		__ATTR(cpumask, 0444, arm_cmn_cpumask_show, NULL);
>
> -static struct attribute *arm_cmn_cpumask_attrs[] = {
> +static ssize_t arm_cmn_identifier_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "%03x%02x\n", cmn->part, cmn->rev);
> +}
> +
> +static struct device_attribute arm_cmn_identifier_attr =
> +		__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
> +
> +static struct attribute *arm_cmn_other_attrs[] = {
> 	&arm_cmn_cpumask_attr.attr,
> +	&arm_cmn_identifier_attr.attr,
> 	NULL,
> };
>
> -static const struct attribute_group arm_cmn_cpumask_attr_group = {
> -	.attrs = arm_cmn_cpumask_attrs,
> +static const struct attribute_group arm_cmn_other_attrs_group = {
> +	.attrs = arm_cmn_other_attrs,
> };
>
> static const struct attribute_group *arm_cmn_attr_groups[] = {
> 	&arm_cmn_event_attrs_group,
> 	&arm_cmn_format_attrs_group,
> -	&arm_cmn_cpumask_attr_group,
> +	&arm_cmn_other_attrs_group,
> 	NULL
> };
>
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
