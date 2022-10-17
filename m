Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D07600BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiJQJ50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiJQJ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:57:22 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47E353A4C;
        Mon, 17 Oct 2022 02:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xv9fUCMNI9HGk7J2gytVDuNUa30k9JM6dtlERqSMq6eIEUMa1pXm3CybiUYcUX1oqlWE6F42FNg2kplXlTWkbwXfrzRXPM00ZftgCSjovKVIL0gB0/Jj4rauSJI/I66weGZ1UcEahPYe56NXHMCIbeBlx/DXlQPVghw9X5KkoFiqG7SpossA7vTNbkJ+mUl/d8GjvZ8GOyrLjV4OD2j9RTwPqZaqhbDK6AG2dZdYuaeqE5dk/Zaimu0IVUUbPvWpdVfBsyBQxR9kK/eS8IinYP8P+B3+eRX1cUg3YYhz8JzDS2AWYrDGxazF16PDNBfzk63c5t3zwR3MgS9tl2waMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhJkLbUHuwkA31VujgzrrmQW5YizwIrv3gBENgKlOK4=;
 b=jIuVVJTJv83qZ4nZyDnKIsVdKu0+HMe+UvUUwDtGWXNfODokYfz2hg+fAsYryktCUA50yRPsXS0NiN7DZe7658vAIyNCnIyImiJ5mdi4TC2lhF7B8u2mSg0lRDGX8s+eFjAMUDwri2b9ZtJLc332+EH+HurfPhSrNvpcMdK85+WaUUL1PX0D1LxtWPmXDe+vUWuZiSfO/CVbNnMNouuGSE+5A/g8zTRX+Ma8rQ9NrMapKFR4A2ITYNnVlgDyA7CACTFtvb9hhuBZh6v+hup89iohy3+H9Il975WbLgG/Rn0WIRDbGeZ94G/Mx6x5ghgah5rYI2TGLjlDHbHW2a910Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhJkLbUHuwkA31VujgzrrmQW5YizwIrv3gBENgKlOK4=;
 b=RzncCFYxSJFshOJw3aKliKqa3smMZytwzN0PFU5xk5O4ZEwNOYqdOrz9ViANqccyqgcOX9+ll/fnvlec8o5STqNzwKJY36zUvmfJYmDWRsawA0St929pVHBbrr7yJJrxoQg5nk6h/JmojqZRr/6nNSfH6cHymZ/Df0ecIcr9E40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Mon, 17 Oct 2022 09:57:18 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 09:57:18 +0000
Date:   Mon, 17 Oct 2022 17:56:56 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2 4/9] x86/msr: Add the MSR definition for AMD
 CPPC boost state
Message-ID: <Y00m6Fm6AKqh65Fr@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-5-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010162248.348141-5-Perry.Yuan@amd.com>
X-ClientProxiedBy: TYAPR01CA0161.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::29) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ca2bed-6512-4a15-2948-08dab025f9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5NW2jgPx7z9klQjWVCez/iQNOFz/LRS4kiWECkIjvo1Aa22lRFgJkQKxyozNxzyzFtaOzLUeitMDVZ+MkaYjWUmK5tYzb/BSgqAM8fMuz3wpxSPXELH+55v0Itj7yQE1TsGdnvoxRhlUGzDnDIMdrWOLv+b2EhwTZCLSUoG4b2+jpM26Z0/ga8BPOf2E35ZRelYXyCQwDLWBoSNkufUeJ5X92E5SuSw547CvbDoQf1xR77loMKQhCRoI+i3WAA7JJO8FDne3fZDf2VSZav/aWXHS0N/4CMDkX+yu/SMAOYxGUL7ASG3uJ/lpYYVczhF9OIwpTU23bgeL8yQY2tBTVtCBpmu+ySW6Nr8GjwoiTYf6b8TnJEIfpsKKNinYuulaBJC8CohUDEQ5j8nNIgsBaX/DTnii61Qz0SrNa/971P4dWEu2CUjDXoRPieWSybYZG/+8y56ZU73R9t5oiKmFHMVr2SO4dhXZy2+nyWdLuI7bWwo2kwNEm25k0rJWfyeB2G/+dUSY8pcrTpcgyl2781wZnrv6iuWoUe3X1ahU3UJDDiSRxglgWF3QB6JAOVwQpsnYAOsjxhunxukHb5oKFcMBPnLF2VWKrXyeXdq73jOyPW9RjRHDLOIaE1FiGl3B9X0AT1GpCAqJbQGFDJn6X2O/xDHKQYVkMIwIpx7wNqbeGi+F6xL7Fpv4/Ykplbpgf24iUwXfxYggFXeH2tFuT/+4iztv5WtmVs7XeF4agXrEaXRMCpng8n2S8wtS71p+UbR1i1mshceYWTAv1aX3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(4326008)(8676002)(6666004)(66476007)(54906003)(6636002)(37006003)(66556008)(83380400001)(66946007)(6506007)(36756003)(86362001)(41300700001)(5660300002)(26005)(6512007)(6862004)(8936002)(316002)(2616005)(2906002)(186003)(38100700002)(966005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mk0fHIpeWTySLpZil68Q6tqlLLeyTE1/4+9szqHA4Rb8fjUWpKBU68qdB3kN?=
 =?us-ascii?Q?bi0hcg1aG4OTDPqRrX7pSU3F5jQ1/eaOpcZE9x/2DkOZCr7qUwFh78GZZ8uf?=
 =?us-ascii?Q?fWkfWGxRjhJA+WSv08Nd8EjQz5E16yYu43TCF67ezN8pQgoNO647coC8take?=
 =?us-ascii?Q?e0twqdN6bKRAIMnlEA21PwZiaZV6n7Wb/7c8y1M0pzS0GiIOfC1r/XjxR+Mb?=
 =?us-ascii?Q?vHjDxZ5M6fU0IalHrj5CHX0wLxQdupt8uDFu/InLgI1siAWwBhrFBbBBdGSK?=
 =?us-ascii?Q?RJwB2h+pT4d8vrNyu/R8Yr5O7e6VpGQQDkAPeHIs/DOmhacUL7RWB/0/WQj8?=
 =?us-ascii?Q?tre2xOPSS15egZWDkIHc3L1m+YJ+E81Jvav7HbO+u28elVDmRZ2bF3xmk7bP?=
 =?us-ascii?Q?gqzAGGuKzmJE6M3S3B8z7ta8tseJOz9G1vIwkW6EoMO+7V8GLAmRZTIfsiLc?=
 =?us-ascii?Q?Aq78FzaoxHmgJ4rVAaL28zsqJSJBvYH/JFTdzcTShAJ0UFWuYiXYCRB+0ioZ?=
 =?us-ascii?Q?ILUloLjXhCSJ0W6BKxPXixsOFtFPFtoL3coEW4hWm13Wo12urqpC7IkJr2VZ?=
 =?us-ascii?Q?PCnQ/BlG/rZyskXXtApk6eTHc+XCoTj1hyoYDLC2gXftKqBU2ww9LabsC2zX?=
 =?us-ascii?Q?mghKJ4eWyfYZHtUMH3qfGUl68nAwlrvYo0dPKixJPf+5H1bYqza8GClrPc6Z?=
 =?us-ascii?Q?Q1T67UZDZrXxgnbcheNH2EUFYnM6gZQIgyhFxWRSnApq1ijGFF01YjIjwOkT?=
 =?us-ascii?Q?Gm3m2BZh4JSgEhDQwI+iGUkvvOpSqqsp+Pxpj0bLugMW++ekavaaqn8OnJnN?=
 =?us-ascii?Q?bKWnm613DOIiu8w0r8lC2OtkmFNfs5fwoxeZ7eyS1xLO2K1pshlGx14Qkp07?=
 =?us-ascii?Q?qmhSyIvrEjgSI74c+bLtPPyYeoa3G4m6GGJTmX61ZGx/qGEqXhgBhDqps8IG?=
 =?us-ascii?Q?9D3S/UKTD0Gyf8Lx0qLoug95UnF3MDcBG+seIPBN4Z/gM+flLCvJef5uN8WR?=
 =?us-ascii?Q?JV0csxfFWEvF6h+u4iYLoAPlZkwHJY32DzgVUWdvh2djKV2SMKxwEwrFwmtU?=
 =?us-ascii?Q?2XLHdy+w8OIEjanNDBMfvpjU3mYk+8Vx585OdyDMkn9Hc6v29ityVJ2fm3EI?=
 =?us-ascii?Q?/m30tU37mlpj80NdqOoPacFIJmLBjZRlm+tLf1NYuEY36aCyWYxcuN0r3K1a?=
 =?us-ascii?Q?Ju88KNqrp0mH3L8rvorBt0LAIBhewB7ZUcRBwnp2BzkretkmQq6p+xThZVbA?=
 =?us-ascii?Q?gG32/sqB6eW9IEy5B4zlI5FLFHzifOTEbNLIE5moPmJrWVxUjvwFlM92pYsP?=
 =?us-ascii?Q?pJK3Do9+I5p8nhL+l6DRv+MzPsmzQoNPWYV0gBS3fOl8rbj095TjpoMgVyix?=
 =?us-ascii?Q?XbvIfC03ic+jBQgXT7NA2Uu2H1tsuSw8yvmv1auNyzbAez55qol37a7K2MdS?=
 =?us-ascii?Q?NNCxudwLKO3KEcn/zn9Yd1xOC/IYCXPB4dyuD/Pu7J84zhYHfLv9WkqMmG0q?=
 =?us-ascii?Q?5TrIHKY/iy8MMevMNsf1zfd8ihlQ50Gd/0RFbbGMNj0fp0LfVLAFUWleeVG7?=
 =?us-ascii?Q?hnjIorBYqvE6q8qDEdY+qesu9WJoUN6HsDI4gaUR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ca2bed-6512-4a15-2948-08dab025f9e8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 09:57:18.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+u1DsPGabr/5TQ9Eo44QQet1DGR0go6OM5qG3WyX0ZqC2oEJCWS825aUle5GnOZkr/1uWOTfvhF5WYdKUIaZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:22:43AM +0800, Yuan, Perry wrote:
> This MSR can be used to check whether the CPU frequency boost state
> is enabled in the hardware control. User can change the boost state in
> the BIOS setting,amd_pstate driver will update the boost state according
> to this msr value.
> 
> AMD Processor Programming Reference (PPR)
> Link: https://www.amd.com/system/files/TechDocs/40332.pdf [p1095]
> Link: https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip [p162]
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  arch/x86/include/asm/msr-index.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 6674bdb096f3..e5ea1c9f747b 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -569,6 +569,7 @@
>  #define MSR_AMD_CPPC_CAP2		0xc00102b2
>  #define MSR_AMD_CPPC_REQ		0xc00102b3
>  #define MSR_AMD_CPPC_STATUS		0xc00102b4
> +#define MSR_AMD_CPPC_HW_CTL		0xc0010015
>  
>  #define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
>  #define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
> @@ -579,6 +580,8 @@
>  #define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
>  #define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
>  #define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
> +#define AMD_CPPC_PRECISION_BOOST_BIT   25
> +#define AMD_CPPC_PRECISION_BOOST_ENABLED       BIT_ULL(AMD_CPPC_PRECISION_BOOST_BIT)

I had commented the MSR_AMD_CPPC_HW_CTL is duplicated with MSR_K7_HWCR

https://lore.kernel.org/lkml/YtX+uF/nAIG0ykHN@amd.com/
https://lore.kernel.org/lkml/YtX586RDd9Xw44IO@amd.com/

Could you please make sure address the commments?

Thanks,
Ray
