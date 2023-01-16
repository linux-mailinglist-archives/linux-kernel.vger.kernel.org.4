Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D6666B86D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjAPHui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjAPHuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:50:35 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D085589
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:50:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OusQ+4YdJPMDyx3dd0W0bNfKJqgOG8Gd/c78XldzLMAOFdAg5rXxr89844GJP1XIKmQ4qUlbggSDAIDihdgQoa7eDp2ZtjBt9NOkWZz3Mo2lnSCeRC9+zu58+1V9YBB2f5y22l2idcC0nnhtVHCQ+hVRBVytQ8WZyQMcRAF+plg4axY2sY/i0phfOXfSlJq83PK3zfVxQwY10eMYHO2Gy6ZJPHYd5R6vaIPwruMUFerzWQvpJSQ0uTcWRswh0pBaTJugebO+gka11J7Vh2rUXTvVOgSoumxzqHP/7FYL5ETyUE9KEf4TXqzRus6YAMPFu4XFGP7JSwPDHOcA4sEicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjiO+Wzi9RBS7yosq2phQ6WZAB0osf3vyIja1MANFs4=;
 b=dUyGRVCrDH7wYQQegTZ1VugH+3OyA9Z/vR2rpH5qy3rK0rQ5vF+laAqap9nZbPZM9sVVEHHHNzxblKzbvPDBZl0iZyjaoP+PTttSVHuIlCgLDzYJ1fBofzQUkitKhZbyXba0waXqW3DK+R0fs/CvbMCR/B5xUMm2fSNC0TkFxXkneCXW/SkghdNGqvkK+ld6XJ8pBXWn8/Fstzgcht+yNZCtm9WTNM61FPRY2BDRffJCo+0Ycd2+YU1IcCsthtecpx2ziuhODYKkjbLVtPyOJvih+mRjy6wRRgS50yc4wh6i1stvocomBkQIaNz5Nuxi9fFdGsocDsq2fPLMy5L9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjiO+Wzi9RBS7yosq2phQ6WZAB0osf3vyIja1MANFs4=;
 b=dYBtNsmrKgGMTeaBhe7hkDmHLQilHNsSUXhmksyBvYAEI+3lXT2P1tnaHE0DzIsEUMlth7KWE29132ludIvHmmtbVrCRc9iVACUBW4Zq7+bzEt57YVPTWIFjJH14171sWzzsSl8r1fxIRwlKg5fsJZlIizl8+Qws3QzNgaNX0fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 07:50:25 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 07:50:25 +0000
Message-ID: <dbf20726-3900-9bff-7a72-14608702f636@amd.com>
Date:   Mon, 16 Jan 2023 13:23:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/19] soundwire: amd: Add support for AMD Master driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-3-Vijendar.Mukunda@amd.com>
 <991ff630-17a7-eef3-1436-e4a905fe0541@linux.intel.com>
 <78741dee-9257-77c2-8950-0519ccb462e6@amd.com>
 <420258d4-1f66-5288-f421-b26b2a2a35ea@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <420258d4-1f66-5288-f421-b26b2a2a35ea@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::18) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CY8PR12MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcea408-278a-40bf-9581-08daf79653c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byTKsbTxPdZF6/w5au+MsbEMudaqjeW1dfVF2CnMloY0Zdp7yvhWrNKURglWsHhbO1j6ukwnj4B9e89qdpnwmaeWF04RevnFabOk0X6hXhNrZXw/D+Oup44X4QnsUB5n4wGMNDDJEfF5ESQSXwTzR5xKaZ+T/czEXhOri5V0rGNdNvjTNNhuC+G4mXBd2OJzV72KuUtNlx3hiqbY6JB4NFqXlnyY1JSUItQxXFreiEanGDz6JcWrhjrAI3uRoTNIPiL05IYL62DPHWqsU2xZUiS5zbTh/t5aefohwBuyd/aIY9LkQxYPPDA0rXjdmCYOPBx2My1Ddk9IxUKbrDuX/SNkiK/MdbL6ZTuiFlTAshmkRo/e3DmDTOIplsJSjPZ18zYQFHTBpMjPeHvTvhWf8G9XGIzdT2jh1SO62EYe/RaOnAW/1Cf1tXgz9MoZ8MLtMGh1vr2vxHmxkChdEb8rwXTFoJU/JgcO4wajIaR/dP60fxBWsHo/qrZpAFk7WpZWKoj4peHHNN+tMGrI4/gIFpKL0YtZW2PpJIEB7wDl96+2E5AR8mYc+1J3th3v1WGQx8QvCiPkvh3sUzn71ehgoCsQHakyCDRjEt5ZY4CQ6A/Y4LFVVaMyGZxxOblpOm7wM7Baq/OwNl7L+IoU1kU8QlEVzfPSWOpKh2K03hkGE74yXpwzCUJu+Y2w/bEhCZS7mTlY5usAIxAGGHsOR3lDWltcaXz8CN8HUl+v8LhM5ciMtI4C/pCsVpxw0ov6rj0Qcgg1K66dg0YlYcziMeRViQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(45080400002)(478600001)(41300700001)(966005)(6486002)(6512007)(38100700002)(31696002)(86362001)(316002)(54906003)(2616005)(186003)(66556008)(66476007)(66946007)(26005)(53546011)(5660300002)(6506007)(36756003)(2906002)(6666004)(8676002)(30864003)(31686004)(4326008)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmU0aXZFeUU2Szg1UTZZRk1SZzZ0RERnZ2pleWhKVDJQaGt4ZmxrNW5Eck5U?=
 =?utf-8?B?bVdTYW1zNVZBeXh3Vk5MaElYdUFxTnRvUTZreHlyZzYyWXB2QVdEalJkdGd1?=
 =?utf-8?B?TXNhdW53YWlJQnFLSElaWHFBakZjc2c5RVZvUVFYZ1BMS3RGam9WWW1zWXhO?=
 =?utf-8?B?UWF0TEdhSzNGZEpMcmRONkYrU001SmUxQTl5MVZhVTNBZnk3cEFud2RNaElh?=
 =?utf-8?B?NWVQako4MEJYL2VsMWtIOS9xNlovT1A4M1ducXZwY1R6dHZKeTFZSFJjSjg4?=
 =?utf-8?B?SGVONEU2TFpLekR3S2k0Slc0bkVLMXVpYU1IeVJQWHRrTktITTRiMnZsOGF6?=
 =?utf-8?B?cjJpUDg5OEh4bDQ2eWlKZnpKei94ZG9GblhsSm05Z3hPeTJNbENxeUtDQTRW?=
 =?utf-8?B?YmRZQURmUXJKTUZxeEhISGV5eUs4YW45SHpkWHI3UzZneDlGMEQ0UHh3KzNk?=
 =?utf-8?B?Q0Erb2tkYm9STmp6c1E1N3oyQ0lvMHcvU3BCQy9UY0FSZ0hyZE5Xcy84TXZB?=
 =?utf-8?B?dVJrZjltSmx2cTBXdWJHc0MxTld5NnkwRVBJTlJPSFJIZk1IWlJEN2p0UG5m?=
 =?utf-8?B?WkNYMHdWRitiamR6OEF1SXE3RkNVMGFTeThNSHY3TEUveHJUbERNRzRvWUdn?=
 =?utf-8?B?bGhyODlDaENEVXVnNmp6TGx6STBOdEswUzRtM09DdHFhZDZLSzE5akYwYkJK?=
 =?utf-8?B?QjkvdXlRUlBzMEhYNkdjbXNPamRlTFVyTnRCU3pNa1NSeHZTY3FjRGdxb0NS?=
 =?utf-8?B?SFFQalNRU0pYVmhidStvUHJpYmJZS2oyaisrL2s3bE4yNFIrOUVobEtxSWZ5?=
 =?utf-8?B?S2M2Um1BemdHblpmMk0vaHdET1ZBNmpoZGxJRGovZ3pRZ2l6Nk90UllzR2ZS?=
 =?utf-8?B?N2NCVVRhcGRITmF3ZzVQU2hIcXRaUS9rM1N6b2V4ZnRxNkpvMlN1MWt6cGgz?=
 =?utf-8?B?eWtZK2t2bUVIM0JaeUs2anc2VWFESW8wM04rbWhjNTBTNDgvcFh5aElnUm9p?=
 =?utf-8?B?aDJ2SVJpc3cyR0xEdlhxc2ZMeHN2cmRrTHNIRVVMYmVxdUQ0MVZkeDJEazh3?=
 =?utf-8?B?R0tCNkpYcW9vajRxSkFobFZGaVhxM29hQll0TTRXRitXR3BiTUYzWTBpTm5h?=
 =?utf-8?B?N0dJOHF3N1JHQkR1NlVmcUhPV3dPVndRbi9ZblJsOVhMVkUvOWo1dFpBMjdE?=
 =?utf-8?B?MkpOVEVRVGpraUlQaE1CaVgxNWJzVEpxdnBYS2VNdm1kbVNIQS9HOEQrVzBP?=
 =?utf-8?B?RXVSOUdqWWZXTWR2bUtqYy9hNGFzSlBTL0l5VmxldU1aRjBtTUk5aGNETVZ4?=
 =?utf-8?B?eDZnSWtXdHp4cS84NW9HQ2ZlNUhuVlRsS3paN3hFQS81VTlvOG1GK3p3NzR5?=
 =?utf-8?B?eVNsQkpZNEgvRFhzRmZwU05aVnlxMGI1ckF1cjV1ejIyN2NoMjFtaFRhZ2to?=
 =?utf-8?B?MTZmS29YTURYY2t6N1JOanNUNWdzdEhJRUtGRVVqZysraVpxemEyc2lIaUUv?=
 =?utf-8?B?UU4rajh5eURGRi9oMEd3QlJGb0IwcUhmU2hIL2lsYkVvTHh1eGxSNEpSMG5V?=
 =?utf-8?B?M2xCWFZpSk9QbU1RUzNCZUtCTGF1ais3ZkFCN2ZaVk1ZVlI2TWZTMy9hRVJp?=
 =?utf-8?B?Y21kMWJoV0cvSEpIMGo5WXBTV0lNSDdxejVJRitkdloyL0QvbzVVZHc1T01M?=
 =?utf-8?B?UVNsNXd0cmZGMnVwWExZZ280Smxxa3FUMWlWTGFSUERIc2d2UHdaWktVaHpM?=
 =?utf-8?B?Z3BPYjJDT1o5VWpuUnF6VEROcDZxLzA0YUZCMXhOTElmckp2SnV5YnZ4d21h?=
 =?utf-8?B?UmpNMjFSTDF0VUEvMjYvRERzcnFuWjN4SWxLckp3aGczREVBMitnL2Rac1pO?=
 =?utf-8?B?TDlYRGJvT1daWFNxRGtwWFhzQk94Mm9FVWhtQWZBV1lIU0NzTUEybTA4RitB?=
 =?utf-8?B?K1J0Qjd1ekZZTWcwTE8zY25YRWV0TlZQaXZIOGcrRzIyam1yNFZuQVZ0aitt?=
 =?utf-8?B?aDBFaFE4TzU0emZSUmdWM29PM2xadndMOG1rbXUwT3ZCdVloSjdkZ2ZJZDVX?=
 =?utf-8?B?TEJDYXB4a0dVRmptSW85TGlyci9XTGdnYTRZTFVKbXZvWWNjYXVmWFZVRGVw?=
 =?utf-8?Q?dwYw6LKAqibvqSwOhQS65jN+i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcea408-278a-40bf-9581-08daf79653c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 07:50:25.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9Pu4uQICqnPYsG4gVEuMd2R05QTOZj+mqf9UJKu8BFM783ojOtJBvR4HDHgy2btRA2URm3818Vakc/nv0dMjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/23 00:11, Pierre-Louis Bossart wrote:
>>>> +	for (index = 0; index < 2; index++) {
>>>> +		if (response_buf[index] == -ETIMEDOUT) {
>>>> +			dev_err(ctrl->dev, "Program SCP cmd timeout\n");
>>>> +			timeout = 1;
>>>> +		} else if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
>>>> +			no_ack = 1;
>>>> +			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
>>>> +				nack = 1;
>>>> +				dev_err(ctrl->dev, "Program SCP NACK received\n");
>>>> +			}
>>> this is a copy of the cadence_master.c code... With the error added that
>>> this is not for a controller but for a master...
>> Its manager instance only. Our immediate command and response
>> mechanism allows sending commands over the link and get the
>> response for every command immediately, unlike as mentioned in
>> candence_master.c.
> I don't get the reply. The Cadence IP also has the ability to get the
> response immediately. There's limited scope for creativity, the commands
> are defined in the spec and the responses as well.
As per our understanding in Intel code, responses are processed
after sending all commands.
In our case, we send the command and process the response
immediately before invoking the next command.
>>>> +		}
>>>> +	}
>>>> +
>>>> +	if (timeout) {
>>>> +		dev_err_ratelimited(ctrl->dev,
>>>> +				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
>>>> +		return SDW_CMD_TIMEOUT;
>>>> +	}
>>>> +
>>>> +	if (nack) {
>>>> +		dev_err_ratelimited(ctrl->dev,
>>>> +				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
>>>> +		return SDW_CMD_FAIL;
>>>> +	}
>>>> +
>>>> +	if (no_ack) {
>>>> +		dev_dbg_ratelimited(ctrl->dev,
>>>> +				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
>>>> +		return SDW_CMD_IGNORED;
>>>> +	}
>>>> +	return SDW_CMD_OK;
>>> this should probably become a helper since the response is really the
>>> same as in cadence_master.c
>>>
>>> There's really room for optimization and reuse here.
>> not really needed. Please refer above comment as command/response
>> mechanism differs from Intel's implementation.
> how? there's a buffer of responses in both cases. please clarify.
Ours implementation is not interrupt driven like Intel.
When we send command over the link, we will wait for command's
response in polling method and process the response immediately
before issuing the new command.

>>>> +static void amd_sdwc_compute_slave_ports(struct sdw_master_runtime *m_rt,
>>>> +					 struct sdw_transport_data *t_data)
>>>> +{
>>>> +	struct sdw_slave_runtime *s_rt = NULL;
>>>> +	struct sdw_port_runtime *p_rt;
>>>> +	int port_bo, sample_int;
>>>> +	unsigned int rate, bps, ch = 0;
>>>> +	unsigned int slave_total_ch;
>>>> +	struct sdw_bus_params *b_params = &m_rt->bus->params;
>>>> +
>>>> +	port_bo = t_data->block_offset;
>>>> +	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
>>>> +		rate = m_rt->stream->params.rate;
>>>> +		bps = m_rt->stream->params.bps;
>>>> +		sample_int = (m_rt->bus->params.curr_dr_freq / rate);
>>>> +		slave_total_ch = 0;
>>>> +
>>>> +		list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
>>>> +			ch = sdw_ch_mask_to_ch(p_rt->ch_mask);
>>>> +
>>>> +			sdw_fill_xport_params(&p_rt->transport_params,
>>>> +					      p_rt->num, false,
>>>> +					      SDW_BLK_GRP_CNT_1,
>>>> +					      sample_int, port_bo, port_bo >> 8,
>>>> +					      t_data->hstart,
>>>> +					      t_data->hstop,
>>>> +					      SDW_BLK_PKG_PER_PORT, 0x0);
>>>> +
>>>> +			sdw_fill_port_params(&p_rt->port_params,
>>>> +					     p_rt->num, bps,
>>>> +					     SDW_PORT_FLOW_MODE_ISOCH,
>>>> +					     b_params->s_data_mode);
>>>> +
>>>> +			port_bo += bps * ch;
>>>> +			slave_total_ch += ch;
>>>> +		}
>>>> +
>>>> +		if (m_rt->direction == SDW_DATA_DIR_TX &&
>>>> +		    m_rt->ch_count == slave_total_ch) {
>>>> +			port_bo = t_data->block_offset;
>>>> +		}
>>>> +	}
>>>> +}
>>> ok, this is really bad.
>>>
>>> This is a verbatim copy of the same function in
>>> generic_bandwidth_allocation.c
>>>
>>> see
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Fdrivers%2Fsoundwire%2Fgeneric_bandwidth_allocation.c%23L38&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Ccac3e7985a9347a69be908daf3f1ea8a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638090517594233520%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=MhN0eJYtggAnkUyb6mDIWW8LvwGeS8JJ%2F2UBHkHHOYo%3D&reserved=0
>>>
>>> You only removed the comments and renamed the function.
>>>
>>> Seriously? Why would you do that?
>>>
>>> And in addition, this has *NOTHING* to do with the master support.
>>>
>>> Programming the ports on peripheral side is something that happens at
>>> the stream level.
>>>
>>> I am afraid it's a double NAK, or rather NAK^2 from me here.
>> Our intention is to implement our own compute params callback.
>> Sorry, instead of making a copied one , we could have exported this
>> API.
> ok.
>
>>>> +static int amd_sdwc_compute_params(struct sdw_bus *bus)
>>>> +{
>>>> +	struct sdw_transport_data t_data = {0};
>>>> +	struct sdw_master_runtime *m_rt;
>>>> +	struct sdw_port_runtime *p_rt;
>>>> +	struct sdw_bus_params *b_params = &bus->params;
>>>> +	int port_bo, hstart, hstop, sample_int;
>>>> +	unsigned int rate, bps;
>>>> +
>>>> +	port_bo  = 0;
>>>> +	hstart = 1;
>>>> +	hstop = bus->params.col - 1;
>>>> +	t_data.hstop = hstop;
>>>> +	t_data.hstart = hstart;
>>>> +
>>>> +	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
>>>> +		rate = m_rt->stream->params.rate;
>>>> +		bps = m_rt->stream->params.bps;
>>>> +		sample_int = (bus->params.curr_dr_freq / rate);
>>>> +		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
>>>> +			port_bo = (p_rt->num * 64) + 1;
>>>> +			dev_dbg(bus->dev, "p_rt->num=%d hstart=%d hstop=%d port_bo=%d\n",
>>>> +				p_rt->num, hstart, hstop, port_bo);
>>>> +			sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
>>>> +					      false, SDW_BLK_GRP_CNT_1, sample_int,
>>>> +					      port_bo, port_bo >> 8, hstart, hstop,
>>>> +					      SDW_BLK_PKG_PER_PORT, 0x0);
>>>> +
>>>> +			sdw_fill_port_params(&p_rt->port_params,
>>>> +					     p_rt->num, bps,
>>>> +					     SDW_PORT_FLOW_MODE_ISOCH,
>>>> +					     b_params->m_data_mode);
>>>> +			t_data.hstart = hstart;
>>>> +			t_data.hstop = hstop;
>>>> +			t_data.block_offset = port_bo;
>>>> +			t_data.sub_block_offset = 0;
>>>> +		}
>>>> +		amd_sdwc_compute_slave_ports(m_rt, &t_data);
>>>> +	}
>>>> +	return 0;
>>>> +}
>>> this is a variation on sdw_compute_master_ports() in generic_allocation.c
>>>
>>> You would need a lot more comments to convince me that this is
>>> intentional and needed.
>> This is intentional. We have a HW bug, if we go it generic bdw allocation
>> API, when we launch multiple streams, we are observing noise for shorter
>> duration for active stream.
>> To avoid that, we have slightly modified the sdw_compute_master_ports()
>> API. As of now we are enabling solution for 48khz, 2Ch, 16bit.
>> We will expand the coverage in the future.
> That's fine, it's perfectly ok to have different strategies on the host
> side. Exporting additional functions from generic_bandwidth_allocation.c
> would help, you can pick what you need.
>   
>>>> +
>>>> +static int amd_sdwc_port_params(struct sdw_bus *bus, struct sdw_port_params *p_params,
>>>> +				unsigned int bank)
>>>> +{
>>>> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
>>>> +	u32 channel_type, frame_fmt_reg, dpn_frame_fmt;
>>>> +
>>>> +	dev_dbg(ctrl->dev, "%s: p_params->num:0x%x\n", __func__, p_params->num);
>>>> +	switch (ctrl->instance) {
>>>> +	case ACP_SDW0:
>>>> +		channel_type = p_params->num;
>>>> +		break;
>>>> +	case ACP_SDW1:
>>>> +		channel_type = p_params->num + ACP_SDW0_MAX_DAI;
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	switch (channel_type) {
>>>> +	case ACP_SDW0_AUDIO_TX:
>>> you'll have to explain what you mean by 'channel_type'
>>>
>>> This looks like the streams that can be supported by this master
>>> implementation, with dailinks for each.
>> SDW0 Manager instance registers  6 CPU DAI (3 TX & 3 RX Ports)
>> whereas SDW1  Manager Instance registers 2 CPU DAI (one TX & one RX port)
>>
>> Each port number on Manager side is mapped to a channel number.
>> i.e SDW0 Pin0 -> port number 0 -> Audio TX
>>     SDW0 Pin1 -> Port number 1 -> Headset TX
>>     SDW0 Pin2 -> Port number 2 -> BT TX
>>     SDW0 Pin3 -> port number 3 -> Audio RX
>>     SDW0 Pin4 -> Port number 4 -> Headset RX
>>     SDW0 Pin5 -> Port number 5 -> BT RX
>>
>> Whereas for SDW1 instance
>>
>>     SDW1 Pin0 -> port number 0 -> P1 BT TX
>>     SDW1 Pin1 -> Port number 1 -> P1 BT RX
>>     
>> We use this channel value to program register set for transport params,
>> port params and Channel enable for each manager instance.
>> We need to use same channel mapping for programming DMA controller
>> registers in Soundwire DMA driver.
>> i.e if AUDIO TX channel is selected then we need to use Audio TX registers
>> for DMA programming in Soundwire DMA driver.
> Ah, that's an important piece of information that should probably be
> captured to help reviewers. On the Intel side the assignment from stream
> types to ports is handled at the machine driver + topology level.
We will add comments in the code.
>
>
>>>> +static int amd_sdwc_transport_params(struct sdw_bus *bus,
>>>> +				     struct sdw_transport_params *params,
>>>> +				     enum sdw_reg_bank bank)
>>>> +{
>>>> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
>>>> +	u32 ssp_counter_reg;
>>>> +	u32 dpn_frame_fmt;
>>>> +	u32 dpn_sampleinterval;
>>>> +	u32 dpn_hctrl;
>>>> +	u32 dpn_offsetctrl;
>>>> +	u32 dpn_lanectrl;
>>>> +	u32 channel_type;
>>>> +	u32 frame_fmt_reg, sample_int_reg, hctrl_dp0_reg;
>>>> +	u32 offset_reg, lane_ctrl_reg;
>>>> +
>>>> +	switch (ctrl->instance) {
>>>> +	case ACP_SDW0:
>>>> +		ssp_counter_reg = ACP_SW_SSP_COUNTER;
>>>> +		channel_type = params->port_num;
>>>> +		break;
>>>> +	case ACP_SDW1:
>>>> +		ssp_counter_reg = ACP_P1_SW_SSP_COUNTER;
>>>> +		channel_type = params->port_num + ACP_SDW0_MAX_DAI;
>>> There's obviously a dependency between SDW0 and SDW1 managers that you
>>> haven't described?
>> No, both are independent manager instances which are connected in
>> different power domains.
> if they are independent, then why does the channel type for SDW1 depends
> on SDW0_MAX_DAI?
There is no hard dependency for SDW1 on SDW0_MAX_DAI.
We will modify the code.
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +	acp_reg_writel(AMD_SDW_SSP_COUNTER_VAL, ctrl->mmio + ssp_counter_reg);
>>>> +	dev_dbg(bus->dev, "%s: p_params->num:0x%x entry channel_type:0x%x\n",
>>>> +		__func__, params->port_num, channel_type);
>>>> +
>>>> +	switch (channel_type) {
>>>> +	case ACP_SDW0_AUDIO_TX:
>>>> +	{
>>>> +		frame_fmt_reg = ACP_SW_AUDIO_TX_FRAME_FORMAT;
>>>> +		sample_int_reg = ACP_SW_AUDIO_TX_SAMPLEINTERVAL;
>>>> +		hctrl_dp0_reg = ACP_SW_AUDIO_TX_HCTRL_DP0;
>>>> +		offset_reg = ACP_SW_AUDIO_TX_OFFSET_DP0;
>>>> +		lane_ctrl_reg = ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP0;
>>> This is confusing. Is this about enabling a stream or selecting the lane
>>> for this port? Same for all cases.
>>>
>>> is this saying that the two cases are handled by the same register -
>>> unlike what is normative for the peripherals where the two concepts are
>>> handeld in DPN_ChannelEn and DPN_LaneCtrl registers?
>> we have to refer the same register to program channel enable and lane
>> ctrl as per our soundwire register definition.
> ok, please clarify with a comment. It's fine but different from other
> implementations on device and host sides.
Will add comment.
>
>>>> +static int sdw_master_read_amd_prop(struct sdw_bus *bus)
>>>> +{
>>>> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
>>>> +	struct fwnode_handle *link;
>>>> +	struct sdw_master_prop *prop;
>>>> +	u32 quirk_mask = 0;
>>>> +	u32 wake_en_mask = 0;
>>>> +	u32 power_mode_mask = 0;
>>>> +	char name[32];
>>>> +
>>>> +	prop = &bus->prop;
>>>> +	/* Find master handle */
>>>> +	snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", bus->link_id);
>>>> +	link = device_get_named_child_node(bus->dev, name);
>>>> +	if (!link) {
>>>> +		dev_err(bus->dev, "Master node %s not found\n", name);
>>>> +		return -EIO;
>>>> +	}
>>>> +	fwnode_property_read_u32(link, "amd-sdw-enable", &quirk_mask);
>>>> +	if (!(quirk_mask & AMD_SDW_QUIRK_MASK_BUS_ENABLE))
>>>> +		prop->hw_disabled = true;
>>> same quirk as Intel, nice :-)
>>>
>>>> +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
>>>> +		       SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
>>> And here too. Is this really needed or just-copy-pasted?
>> No, It's not a copy and paste. We have seen issues bus clash/parity errors
>> during peripheral enumeration/initialization across the multiple links without
>> this quirk. We have also seen device alerts missed during peripheral initialization
>> sequence.
> ah, that's good to some extent that it wasn't the Intel IP behaving :-)
>

