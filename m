Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3905B697E26
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjBOOQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBOOQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:16:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2646835270;
        Wed, 15 Feb 2023 06:16:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNqHd2fRb/I7Lurk987S3NL+EQuo8Esu/Y4GWJ1RpWMJjLd+1VEfHiymKtz8b3oyysQU5DExf+1+1Sb2dZRbWl2pkrXK80RYWLGoK4dmJTUAOL3EFzCqZQSznYDKGo3OcmpJUl9whEDvHndpvGvyi9ZSkZINHFCAB2fbxS70zRZZ3c7tCR2Hza0fM27apMgqgEu4br6n/GrAweRpWD70/0/RLcESYOiF94Hd7alHS9EzB58uDl3ESEQJgMpxSt9TPx4ty2/nasuG1tOEPZ94Pdc1ZXU/Cl6++k64R7XeK+2ZjYpPNHPxC6yBCob/blYG0e6Wcr9PIixXSafZFxgw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgN9DpEQOB9nUDyafFKW+Meoah4VfdnCwt03agyaxDo=;
 b=Rg4FZlSanU7BD44bC7fLWzXDLV7SB5AeBDq3bGqv5yyPZXWGIEin4+nHVXQE2jP6iEgUkp/HO/oWJaUqG+88Zq98aDEHwLqHIuxEWTO5TwJ8N1zqZwga3/2wjluUtptTnV1v9LNlog7P+UZ1iMvfhhez9HZI2YFCu+JYQK8vc9iQfZUdfo9sw7+BfmxWiQX90ZZEyOYw/aAYjcH4OpDvasHkPbx1/+eXq6XuM3L9Aenxr+7IxmEdoAxNaKi8zrF2INylXRXk99ZviLqzf7z4sXjKW9vTOgwTSuldkiOZS2g50PbLK9Vf/Vg2XdO1GMAbAAdrIdlEpkoqrUHtpX/89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgN9DpEQOB9nUDyafFKW+Meoah4VfdnCwt03agyaxDo=;
 b=mfRhJqIghA2TQafUdV7r0ISH1oful1eM5Agxo9rbgD2tNzOv/Xwu17bkgnEUvL4enwexNVK0EkYlZOMQTcjOP96k/ZeFAABZnoYxqFRo35F8xi9QlTRIZSCDmWZ3WSXdlfY4gk5EXY1+ZBUZyRobAmk2M1wYEBB0491F+kKCXkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.22; Wed, 15 Feb 2023 14:16:44 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 14:16:44 +0000
Date:   Wed, 15 Feb 2023 22:16:18 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Shukla, Santosh" <Santosh.Shukla@amd.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        Tor Vic <torvic9@mailbox.org>
Subject: Re: [PATCH v6 2/6] acpi: cppc: Add auto select register read/write
 support
Message-ID: <Y+zpMiiSxLyjWTYX@amd.com>
References: <20230206172157.49887-1-wyes.karny@amd.com>
 <20230206172157.49887-3-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206172157.49887-3-wyes.karny@amd.com>
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: 70250029-5181-43f9-37b3-08db0f5f443e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aK5WHinKTyZmw6d8kW7ZZUf6RDv2Npj7XCsxv55WHS2db1LxCWRP6TQTOsidqOtptPOcCqV5/p8NKeXAF9UmSf2LgdIXzd/7bbDtZao8Jl0RxRmnmeeLpnK9wWbBD5jjzPofGAhfn5IDnp4Z6lBn/9n0dj+9bJQw8RFeaevUz6NnouVHZnw0mvFqacYuXpYHgEknIJ/+My+ngEVNkTpL5o/kZ7REc/pQZQTmYNZ7vqkJ/kzeZTsN0yxxY/HlzcjJO/1k6Vb3mmpcaSrYFIZRDa1yKrF7PJYpxnogQl7ACqSS2mFhd3QRSpZR+5ufp11LXcSxorvPcuNBJvurMETG8TDehJr1Iu1HF5P6XNnKwPeXehGfQBWpTvuGMzO9wSzQxCff4w4nOr0MId4Yn+dNpEey3lhOe89Uf5qaAAI+a67a/mnRoKpHRLzdLf2MSlXdbIm2MXlku1xa0r9oWdu6trTLwMgKrwpg/i+DG/VrRhuu5BoNRWOegFDIhiuC7xlOLcKfsfwU0Xbv6rBFUGO1hR0am9oQW85oue+8kqt1g2JY7eG7+N1laoXaDGk+v/Du+W7RAR7EApR9qpQPzEzhHT4rJT4zOfQw5bN5gJv9YxPbU1K5azth6yT2KW12oCI9AL3KzqktlOovzlQsNv8IlhV0iSF6ncyhe4rGIJMgxuvn37JCm9TTHfsn4aM8O1C4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(66946007)(6862004)(7416002)(4326008)(86362001)(41300700001)(8676002)(26005)(66556008)(8936002)(2616005)(66476007)(5660300002)(186003)(2906002)(6512007)(36756003)(6506007)(6666004)(6636002)(478600001)(83380400001)(38100700002)(316002)(54906003)(6486002)(37006003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VntjLvtLBvnryvMhqgBCbewRGL2oo9yDvMRS66ibVARh/5dVIMpAm7WIrMUu?=
 =?us-ascii?Q?iqpNjB67gbSdf4feLE4jpnXmSJt/vyw2tMFp5AOf+pnkTAaQ8Nvel0IZiXdH?=
 =?us-ascii?Q?rwxzRTXnwwUf5uYzCAfDu43CLe7Q2/4hoTNHnzNhy9T10R0HYdIImoX1KT2j?=
 =?us-ascii?Q?UldUe9HuspcVSl3v8P8oP7x4PrdULx5p0k9dFzZHyrQiLduv0Hj7jt9PTjkE?=
 =?us-ascii?Q?6B/gMquurgY2cDpEdcxgXcEReQRBJqr3OGp6i9uerOWWNQLTM2yF9BAm4TQj?=
 =?us-ascii?Q?3aDefgUgoQI12XwNSOIZxQMaSb3ROlr2M9bbPHf4yJjcGu2Rg7ACrne38h07?=
 =?us-ascii?Q?gH1MzH981A8XlUktGuh/+SZHVAaXDAM9yUuQsmfuR8y93F7HmFxc/PnPPyKk?=
 =?us-ascii?Q?jqlY2aEiRg0fREGJkNIQFQYmFAKlcw74NzJgjW4U8FUoELe51DHvSFaTjHn7?=
 =?us-ascii?Q?oRclEbZ91jKmtIPxqy913v6QI6KABg9mC0UQYKk5Rnx0raYgRZ3J+eE4XvUC?=
 =?us-ascii?Q?Duj2ZyTFSbbyaIwOezwIhYO4jkY5+hh6jP93wazxfZHBXR04iePUu7LTyqMz?=
 =?us-ascii?Q?Xq6UHG+Ueez8CK+2jL7lxhe1s5xrJZvt6jPoU46iYhiAVtnkEZqaCaahKENV?=
 =?us-ascii?Q?PvD1DH+r8XkOJ86hzTiJDMl994qwZ6dC7oSj3GCwfyHxjEJBeADKeOf2nMBx?=
 =?us-ascii?Q?ArFoo99wCa/vApGUA/iP32POIFUS7XNgjfgngn/4A4RhAZI1mq2RYSoFtwFS?=
 =?us-ascii?Q?xVle+DjLnydXJuTVTFW5yEnh6KarY2dDht6JwMK22N3fLf/myhxa9Kymsqof?=
 =?us-ascii?Q?6zcHH9h9Amurp73iYRqhC4mZJ4a/BMAsr1RONevTJ3wacR6875VlOPyUuuM8?=
 =?us-ascii?Q?Sln0qFRDOfLli/s9TifB691jp5LxvkIsOoGA/yrXBQrKNUrC+6f3VoHFup0M?=
 =?us-ascii?Q?LPmzeu/gxm+HEiCMHHIuNO7c5aMCT+mPrzQ5U+1o7p7uhckShlev6KBvdVfh?=
 =?us-ascii?Q?n6/IZ2tRm/3gR1vAj2/vvk7TIVjRGPtbLD17k/2mPwNdQqIAEVp5kiSTNFRu?=
 =?us-ascii?Q?b0byuY7F2AJGOV6thKM4utpOhyg+Za3/WIzqNsXglfTs2mPgkjJHQNpMqN70?=
 =?us-ascii?Q?fBQZqpL0s/qcxv81IQOHUYa/oUISohx+vPgngwmGAJsntgFwXRPDF7vqFUQy?=
 =?us-ascii?Q?GLhdv5SE1Mq0u6MOrMqpbL5QdJSPkf0yF2mW4+hloxO6DbwNy5LsgSxvX2qf?=
 =?us-ascii?Q?5+kW9qeCdPTbMW+Lxtr7n/R36O93/6PBJ85Waks9+gS0QE7a6tHXmU+yqReD?=
 =?us-ascii?Q?Q8KsxGjSTwv8we0HcIAnEC6bWwuJ8JNF7TWyCKEswDjya3nXRLgRlBIVTyEB?=
 =?us-ascii?Q?Z7TWMMlCXxNYsNe8CLRGEr+MJkeSI6Z2y3O/ZlBkmfAWZAGrCezEnopkDIZE?=
 =?us-ascii?Q?/WmKXvh/tOpmdL7R21sBlgl6vC6hKeJoNPnbe/16IffxaLz4FRwHAV7yjDbO?=
 =?us-ascii?Q?pke0WEtTh8dIKRf0C6qfW01any6ZBoHGRg3b+GQQYeepxTRcNasQEVjI4Cqa?=
 =?us-ascii?Q?40E3jelzDq5pEhhVRLQo09IK8YS5c6YvHspWQ5w8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70250029-5181-43f9-37b3-08db0f5f443e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 14:16:44.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1OtpNgRnoNhsihg3dAOuGUzcKqhBe2rIKZFnqR43PzbbWypH8+Xhm1wbVCMuWw9+AeivxzRc3tYD2awF0i9sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:21:53AM +0800, Karny, Wyes wrote:
> For some AMD shared memory based systems, the autonomous selection bit
> needed to be set explicitly. Add autonomous selection register related
> APIs to acpi driver, which amd_pstate driver uses later.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 97 ++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h | 11 +++++
>  2 files changed, 108 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 91f9ef75f7de..1806006a51af 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1432,6 +1432,103 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
>  }
>  EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
>  
> +/*
> + * cppc_get_auto_sel_caps - Read autonomous selection register.
> + * @cpunum : CPU from which to read register.
> + * @perf_caps : struct where autonomous selection register value is updated.
> + */
> +int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +	struct cpc_register_resource *auto_sel_reg;
> +	u64  auto_sel;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> +		return -ENODEV;
> +	}
> +
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> +
> +	if (!CPC_SUPPORTED(auto_sel_reg))
> +		pr_warn_once("Autonomous mode is not unsupported!\n");
> +
> +	if (CPC_IN_PCC(auto_sel_reg)) {
> +		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +		struct cppc_pcc_data *pcc_ss_data = NULL;
> +		int ret = 0;
> +
> +		if (pcc_ss_id < 0)
> +			return -ENODEV;
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +
> +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0) {
> +			cpc_read(cpunum, auto_sel_reg, &auto_sel);
> +			perf_caps->auto_sel = (bool)auto_sel;
> +		} else {
> +			ret = -EIO;
> +		}
> +
> +		up_write(&pcc_ss_data->pcc_lock);
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_auto_sel_caps);
> +
> +/*
> + * cppc_set_auto_sel - Write autonomous selection register.
> + * @cpunum : CPU to which to write register.

@cpu or you can align the name with above function as cpunum.

> + * @enable : the desired value of autonomous selection resiter to be updated.
> + */
> +int cppc_set_auto_sel(int cpu, bool enable)

With above fixed, patch is Acked-by: Huang Rui <ray.huang@amd.com>

> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *auto_sel_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> +
> +	if (CPC_IN_PCC(auto_sel_reg)) {
> +		if (pcc_ss_id < 0) {
> +			pr_debug("Invalid pcc_ss_id\n");
> +			return -ENODEV;
> +		}
> +
> +		if (CPC_SUPPORTED(auto_sel_reg)) {
> +			ret = cpc_write(cpu, auto_sel_reg, enable);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* after writing CPC, transfer the ownership of PCC to platform */
> +		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +		up_write(&pcc_ss_data->pcc_lock);
> +	} else {
> +		ret = -ENOTSUPP;
> +		pr_debug("_CPC in PCC is not supported\n");
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
> +
> +
>  /**
>   * cppc_set_enable - Set to enable CPPC on the processor by writing the
>   * Continuous Performance Control package EnableRegister field.
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 6b487a5bd638..6126c977ece0 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -109,6 +109,7 @@ struct cppc_perf_caps {
>  	u32 lowest_freq;
>  	u32 nominal_freq;
>  	u32 energy_perf;
> +	bool auto_sel;
>  };
>  
>  struct cppc_perf_ctrls {
> @@ -153,6 +154,8 @@ extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>  extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>  extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
> +extern int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps);
> +extern int cppc_set_auto_sel(int cpu, bool enable);
>  #else /* !CONFIG_ACPI_CPPC_LIB */
>  static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>  {
> @@ -214,6 +217,14 @@ static inline int cppc_get_epp_perf(int cpunum, u64 *epp_perf)
>  {
>  	return -ENOTSUPP;
>  }
> +static inline int cppc_set_auto_sel(int cpu, bool enable)
> +{
> +	return -ENOTSUPP;
> +}
> +static inline int cppc_get_auto_sel_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif /* !CONFIG_ACPI_CPPC_LIB */
>  
>  #endif /* _CPPC_ACPI_H*/
> -- 
> 2.34.1
> 
