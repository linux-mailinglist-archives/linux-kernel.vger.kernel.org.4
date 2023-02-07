Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33368CF57
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBGGLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjBGGLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:11:39 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2300F2F787
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:11:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX5jRl0CWgoSNuT+dyIxvoYqXi/dox/9VDw2/ZaWTlMSRLMRKLNjhIVQrcdYxhoOOTfNCixjl4W4+V6HZx1WYISqbn/eI3b+7fsnkNQNMgdiI8DM529mOXU0ENbOphXXeqW/+RQV40S2/5icZ8+E/bMpRwKRxIWppYADuE+DWlKDS7TwwNl12vVib43HlgUEvt9i2Dow+NEOIWd2E6NevxiNM3SfoKyP4uCoUHZd81t5go2VuLDVguoN1/XTNsIQ7Y4WuRcMKXhzHoZjGaGjWe9XMR7rdeC2xQ2NiArB7j559nz/FT5zsr2JgsyETxW4Q2iiHssf3HqQx5X1xfJOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PV6v/WkswbVjsPWdPZSOcb5/h7qKanj/McBDREErgfg=;
 b=MJl4bjZkpXWhpThbEjbdVRdxHU7Ri/91ykk7f/WMTg4E2Xnu+ePspg/zq+wRF/delmFFleEkKbBm0vXgQ30HeHfPR10HJ5qEg7XVUxkTU8nd/Zjoqjy1JHEX9Q4AFnQ+XCn6anW/mLB9TreWxwY+xSOMD7wtokCdUsF8PFfF1NvGB9TUaVRyOSVvWzMki2/rBv6dCLuU/Yuam0lXFbmqNheh355xC9dVYQtffa2XvfSNi05v1qul0pCL0Ky3bvxeJa8VOvFz5Ezz+dY8jgUapxRXGIyrRtOzEQriRkDq0kkOgIvHvlZQKtBCJksyHkuT9/96lR/cq6VKhZ2knRTfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PV6v/WkswbVjsPWdPZSOcb5/h7qKanj/McBDREErgfg=;
 b=X3r2fz32ODtdx4hTLrGi2UmNRsGxnSKKcMJ2Gsuei3fqWdCBeAXhByES0aM3Mhx1F+shSnZflulsrrwnidU3I/PxL2+8mmH5QjUx/zDCGj47Lf47yWMzxk8s5v9Mb5qCAhMXI1AfeS5Y/NaC0LoSg1p+SlFyKAEywwolAqcRcUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Tue, 7 Feb
 2023 06:11:33 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 06:11:33 +0000
Message-ID: <21972585-503c-da7e-6b9c-bd6c0f01a882@amd.com>
Date:   Tue, 7 Feb 2023 11:44:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] soundwire: export sdw_compute_slave_ports() function
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     Basavaraj.Hiregoudar@amd.com, Sunilkumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230201165944.3169125-1-Vijendar.Mukunda@amd.com>
 <84adef23-fecf-76ec-c597-5f8b4be214da@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <84adef23-fecf-76ec-c597-5f8b4be214da@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::21) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8dfbf5-80a6-4e69-f4a2-08db08d21dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhB2HPTb6GUfw5uuAO2Kw2XPNW3+Er8d3G6SLIZjM1agLP3clxjkREfOotpnPMsZzIL0smMe1QZy6zXYUpjLy7SZ3iEpqVsX/gIGixNA9o8QGY0EpshDy4yDzCRks9Fh8uv+jlg9hvEEM7qk1j8yKGKHpEOhQqXUAFdawbQYexi4xU1n1Bt2MeukakZxLxq+MvueLv2IgheWT/YeV5s9YCqJXsdmC4ySbLh1rCcVD2IL3I4+6R/qrH7EhdViKKu8I218Tzs4lAGH2F8tQ9eYgNg2hrZADV21cqyRpsD4JulKSrEOY2RhOMxtdm2epWN8Rfo83DLVGh7zOK6Lr1N2RfjOTHqz/Pgbve4B/oxF2BvyoEfquHrFGiCMX4txbRCYXrGnd5/wph+TytyPJeJ+BLsRiZuEVtOM947+78a3V/2DYgjArCQz/kV234q3M95k3InH2UZ9nRr4yNOb0cU4kQxMp9hk4IzonsKTYRck6Vyi6u+LdbueWiLCYUVB52L56vA+UvW67Poju0ANu0+VgFvwk8MIhkVkgOx61mhovyARXBM0n2k6MKJa0wAkj7A/cL2mpAmEA67ybie8Gp8rbWutRQcljCHbBBrxnhajKAUrJ3ZSRUofN4fnVFzWejhZoLRvTNagZ+Zb3ABUkNJ2OLtuElwn9yKzLG4pigpkWumxLkEntbxQ0RlI3TulvHelJ1EjEdXtt67xuz1/9H23RV1WBeFlpiTrraYrVWO7qJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(31696002)(54906003)(110136005)(8936002)(316002)(36756003)(86362001)(6666004)(186003)(478600001)(6486002)(6506007)(53546011)(2616005)(38100700002)(26005)(5660300002)(6512007)(2906002)(31686004)(83380400001)(41300700001)(8676002)(66946007)(66476007)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEMxK3cwbVFVQ3FseXIvRXVFc3gzMllxeXhmSHdFUmhXVjJGTUYyUDVSR3hj?=
 =?utf-8?B?aDBSYUdMNzVBR2p4MkVWNkZCbGl5RktEN1ZwUU9WdlVDUG02RVBLUzVpWUtG?=
 =?utf-8?B?MXZhQ2NSVVhBdzRmejF0bmpDTktyM0wvK3ZmZkhzcE1VdEVzaXNFYVgvdFlk?=
 =?utf-8?B?UnA4WFRmZVptUlIzeHc3ajNZSWFrbXJoNGhJczhnMlNMUjdKL3pZNXc1VlA5?=
 =?utf-8?B?UEdiSWtSUkI1OVdsS0hDM3N0UklUOGUwNllBSURGU3lHaFh4WGxSR2w0b2lY?=
 =?utf-8?B?MHVGN1VPdktFVkZJL05zRFkydDRpZ2tCRHcySDJTdXlSMTdGalBqeGVrNll0?=
 =?utf-8?B?eDJ2NTZib3hEMTc4bFZFSkovZXRiMjRPYzNqTUFrTXpTQncwMWxtZmxqaUJv?=
 =?utf-8?B?S1NNa3Y4MnBwc0RMRTVJSUh4OHd4UFpGZWdNcEg1ZzNaZ2hZVTlxZkRsN3pu?=
 =?utf-8?B?ZVZmWjlQUWR5MGJaSEZPKzhFSlNuSHZrOFpXWjN4ZGxyNHZ0Q1RNblZYc2ht?=
 =?utf-8?B?WEtLQUI1MHoxWnFINGR2QW9Tb0FKdVRFSC9zTmlvVkRrMnFXWVIrWkVEejRV?=
 =?utf-8?B?VGUrRmRxR0NvZjZZNy9MMEZNK2E4dTEvSFUwMnpRKzlYV1c3bHZXbE5vSVVF?=
 =?utf-8?B?b0JPQ3Bid2tiQzRMWFdTZXRMb3NSUkNBWm1OT1R3UWlRc09ma3pRcklrQlNL?=
 =?utf-8?B?cG9McTJCVm9kT0xQT3lPZmlJUFhmdC9lbmFqL1l0M0pEc1Q2UXg4RnZMMzRl?=
 =?utf-8?B?UjFMWURBY2dtZmdiTUJaRWJpc0dsZ09GVnV6Ui9CZm9KYXRYT1lpM2p5ZllJ?=
 =?utf-8?B?UWxQcVR3bmIra3ZOQUhJOTJHNEtwVWVxNWxFM3RCYkc5TGwzWUJUOHBwd1Jo?=
 =?utf-8?B?T1hFY3dtdTRBdkZWT1hoVUtGOUk3b0JFd24vSkZUbW5YRlBqNzkvYklVWTUz?=
 =?utf-8?B?emk0UzVHRFlZWnEwNUlIZ1JPVUpLcFp6RldGNEZMcGVPMnlQUytNUnlvcXVX?=
 =?utf-8?B?RC9IL2JhWVpBV1Z0d1RSZ1gxZHVSeG1JSWlyTEl6K3U3b0RKWGFGOVhBcmhj?=
 =?utf-8?B?U2Q3cm9jQmRwbmNKaWJjMVNMSHRTNXJ5ck5KZ3BpcGhVbCt3ZUpvU0ZURm92?=
 =?utf-8?B?RjZhZkVQdGpmKzAwV2VvSU1lbzRLWDBNUjhDRVdnMy9qcWtMd243M1pLTlJu?=
 =?utf-8?B?SFkvTlJOem0zdU5qUW4rc0lIZGlacHVTRmQ2aGxTYTV0TlNqWE9MR0FnWWc4?=
 =?utf-8?B?Wk0rNmIyRThNWWVKaTVYcjAxMVAyVUtPTWZyQUZHNlN2cEFZRjRQMDl3Z3lt?=
 =?utf-8?B?Y3FBTDc5dUl5TS92aGN3Q2xXeTdmRzRFZGRNdEQ0ekRmMGltbFVvOFJaZlV4?=
 =?utf-8?B?dGJzZGVtem92bFFkMG1NNFEwYzR2TjJOQlJWSjV3cmY0TTNscUxxZTg1S2I4?=
 =?utf-8?B?QkVXS05jNGN1UFJVeTZRbjNyY1d6TjVtMktsUU5xeTcwWGJseWZ2Mm9XRkFq?=
 =?utf-8?B?bE1zTmJKdno4WGNtZlRzdysrakJnbUczWXpOSEd5eTdrQWdGVjJ4d1RtUEpk?=
 =?utf-8?B?K3R4N3FkQ2YzQkpSVUVNYk9Mak9nY1JiNGgxSHZoOEVrV3lXQ1BBYTF3cnlr?=
 =?utf-8?B?WHJJRlVORnhULzZ4blB4eEdCUnZxNWhPSUJxVnY0R2NienY3REQ5NFIyaHBL?=
 =?utf-8?B?dVFVWFUrV3NMb0JBQ3R4c3ZKQkFaMkEvTHptaEpITVVpd3Jrb1FmekMySC9k?=
 =?utf-8?B?T1ZBK1I2UW5GY29neE5BTUFDekpzV2NrUGdxd3QzMDhNb1pMNnJGZVFsc2Zo?=
 =?utf-8?B?Z2NiUU5vNFo3bzRLV2FDc3pWV2dsZ2d2cC9nSnNMOWxKSVZVVzQ5MStsYmpT?=
 =?utf-8?B?dkNidXJYa1lYOC8zTnNUK2JDRzRPeEE0OVd0TDc4bTQ2YzRTN0J5TmVWSmpv?=
 =?utf-8?B?TzVsWlhTS0ZaTml1TWRMUHZ1VWpYS1lhMjF0bUxab2JSL01FUnpLSDBsSEN6?=
 =?utf-8?B?YzFJa3ZIWGxEakIySEVyQmlrSXViVURWUTRxbm5FRU8wT1NudnhtWXZoQ2Yx?=
 =?utf-8?B?TFlkMTBUOGdsNDFkZU5sWkdleEZRb1BBNEFxNHVLR2RyYTI3M3VDOXp3YklW?=
 =?utf-8?Q?V/NAr9kLFLqRMR+4xihalPZcp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8dfbf5-80a6-4e69-f4a2-08db08d21dcf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 06:11:33.5511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOjHGcalCHXCtQBp2GkwRXrTKxBqF7UtAlGZkFZT+8Tugw8YHWN6vDBl45FPuHi6tbKg1fLm0bQw9yX1d+Fr3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/23 04:51, Pierre-Louis Bossart wrote:
>
> On 2/1/23 10:59, Vijendar Mukunda wrote:
>> Export sdw_compute_slave_ports() function to use it in another
>> soundwire manager module.
>> Move sdw_transport_data structure to bus header file to export
>> sdw_compute_slave_ports() function.
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>
> If a specific platform has a need to modify parts of the bit allocation
> but can reuse parts of the code, that's fine. The 'generic bandwidth
> allocation' was meant to be a reference, not a one-size-fits-all solution.
>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
We will use vkoul soundwire git repository as base and will post the
patch.
>> ---
>>  drivers/soundwire/bus.h                          |  9 +++++++++
>>  drivers/soundwire/generic_bandwidth_allocation.c | 12 +++---------
>>  2 files changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
>> index 7631ef5e71fb..141b99ac58de 100644
>> --- a/drivers/soundwire/bus.h
>> +++ b/drivers/soundwire/bus.h
>> @@ -144,6 +144,13 @@ struct sdw_master_runtime {
>>  	struct list_head bus_node;
>>  };
>>  
>> +struct sdw_transport_data {
>> +	int hstart;
>> +	int hstop;
>> +	int block_offset;
>> +	int sub_block_offset;
>> +};
>> +
>>  struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
>>  					    enum sdw_data_direction direction,
>>  					    unsigned int port_num);
>> @@ -213,5 +220,7 @@ int sdw_bwrite_no_pm_unlocked(struct sdw_bus *bus, u16 dev_num, u32 addr, u8 val
>>  
>>  void sdw_clear_slave_status(struct sdw_bus *bus, u32 request);
>>  int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
>> +void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
>> +			     struct sdw_transport_data *t_data);
>>  
>>  #endif /* __SDW_BUS_H */
>> diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
>> index f7c66083a4dd..39543048baa7 100644
>> --- a/drivers/soundwire/generic_bandwidth_allocation.c
>> +++ b/drivers/soundwire/generic_bandwidth_allocation.c
>> @@ -28,15 +28,8 @@ struct sdw_group {
>>  	unsigned int *rates;
>>  };
>>  
>> -struct sdw_transport_data {
>> -	int hstart;
>> -	int hstop;
>> -	int block_offset;
>> -	int sub_block_offset;
>> -};
>> -
>> -static void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
>> -				    struct sdw_transport_data *t_data)
>> +void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
>> +			     struct sdw_transport_data *t_data)
>>  {
>>  	struct sdw_slave_runtime *s_rt = NULL;
>>  	struct sdw_port_runtime *p_rt;
>> @@ -85,6 +78,7 @@ static void sdw_compute_slave_ports(struct sdw_master_runtime *m_rt,
>>  		}
>>  	}
>>  }
>> +EXPORT_SYMBOL(sdw_compute_slave_ports);
>>  
>>  static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
>>  				     struct sdw_group_params *params,

