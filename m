Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1343F616CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiKBSpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiKBSpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:45:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF232D1C1;
        Wed,  2 Nov 2022 11:45:12 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2ISDvt007072;
        Wed, 2 Nov 2022 18:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eCXx/OsYufkYxy4ZALNhvkML+K3ZqFlk3NgDcY3sh3A=;
 b=dmQIPnk5dhUgFAjS0qattXuAUG7Cgr3rN7TVzZVPIuegSMADc1n1HdOZRjmmVTpyIecH
 U23ovYCAGQpGpDuNvf5ztfBJEPMWCNTH3gP9o1bXLPEuVvizuD7mYlq5ZpFznm5vM3vu
 4DYmpEcQtG39KHsYKwSnDf6+2xoTQlzg/jshHz6kLsU7MHqSzKop7+qjgKpCKnzWu9Br
 99G0OACnn2d2DWS2uwKPlBycPLv/iIOzrP6/WjsPaBNJnxEi4y7HkdqlGc+6agzMBjCE
 p4jcKxyvyIqjrKqsNvR9KXrnrFedUFc5H/XZyGnFpg4lciIeC3LweFeMkeIg/I2jEjy+ JA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kktux8rd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 18:44:53 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A2IiqJA024235
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Nov 2022 18:44:52 GMT
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 2 Nov 2022
 11:44:51 -0700
Message-ID: <7c59a115-36c5-c954-5610-ef5ef1dbb83e@quicinc.com>
Date:   Wed, 2 Nov 2022 11:44:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-14-quic_eberman@quicinc.com>
 <c1f86c53-1d9f-4faf-9313-de86d33e3739@app.fastmail.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <c1f86c53-1d9f-4faf-9313-de86d33e3739@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sguAIVPz2AzPhPEn9JpkakpXfZDrhloX
X-Proofpoint-GUID: sguAIVPz2AzPhPEn9JpkakpXfZDrhloX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_13,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=977 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2022 12:31 AM, Arnd Bergmann wrote:
> On Wed, Oct 26, 2022, at 20:58, Elliot Berman wrote:
> 
>> +static const struct file_operations gh_vm_fops = {
>> +	.unlocked_ioctl = gh_vm_ioctl,
>> +	.release = gh_vm_release,
>> +	.llseek = noop_llseek,
>> +};
> 
> There should be a .compat_ioctl entry here, otherwise it is
> impossible to use from 32-bit tasks. If all commands have
> arguments passed through a pointer to a properly defined
> structure, you can just set it to compat_ptr_ioctl.
> 

Ack.

>> +static long gh_dev_ioctl_create_vm(unsigned long arg)
>> +{
>> +	struct gunyah_vm *ghvm;
>> +	struct file *file;
>> +	int fd, err;
>> +
>> +	/* arg reserved for future use. */
>> +	if (arg)
>> +		return -EINVAL;
> 
> Do you have something specific in mind here? If 'create'
> is the only command you support, and it has no arguments,
> it would be easier to do it implicitly during open() and
> have each fd opened from /dev/gunyah represent a new VM.
> 

I'd like the argument here to support different types of virtual 
machines. I want to leave open what "different types" can be in case 
something new comes up in the future, but immediately "different type" 
would correspond to a few different authentication mechanisms for 
virtual machines that Gunyah supports.

In this series, I'm only supporting unauthenticated virtual machines 
because they are the simplest to get up and running from a Linux 
userspace. When I introduce the other authentication mechanisms, I'll 
expand much more on how they work, but I'll give quick overview here. 
Other authentication mechanisms that are currently supported by Gunyah 
are "protected VM" and, on Qualcomm platforms, "PIL/carveout VMs". 
Protected VMs are *loosely* similar to the protected firmware design for 
KVM and intended to support Android virtualization use cases. 
PIL/carevout VMs are special virtual machines that can run on Qualcomm 
firmware which authenticate in a way similar to remoteproc firmware (MDT 
loader).

>> +	ghvm = gunyah_vm_alloc();
>> +	if (IS_ERR_OR_NULL(ghvm))
>> +		return PTR_ERR(ghvm) ? : -ENOMEM;
> 
> If you find yourself using IS_ERR_OR_NULL(), you have
> usually made a mistake. In this case, the gunyah_vm_alloc()
> function is badly defined and should just return -ENOMEM
> for an allocation failure.
> 

Ack

>> +static struct gunyah_rsc_mgr_device_id vm_mgr_ids[] = {
>> +	{ .name = GH_RM_DEVICE_VM_MGR },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(gunyah_rsc_mgr, vm_mgr_ids);
>> +
>> +static struct gh_rm_driver vm_mgr_drv = {
>> +	.drv = {
>> +		.name = KBUILD_MODNAME,
>> +		.probe = vm_mgr_probe,
>> +		.remove = vm_mgr_remove,
>> +	},
>> +	.id_table = vm_mgr_ids,
>> +};
>> +module_gh_rm_driver(vm_mgr_drv);
> 
> It looks like the gunyah_rsc_mgr_device_id in this case is
> purely internal to the kernel, so you are adding abstraction
> layers to something that does not need to be abstracted
> because the host side has no corresponding concept of
> devices.
> 
> I'm correct, you can just turn the entire bus/device/driver
> structure within your code into simple function calls, where
> the main code calls vm_mgr_probe() as an exported function
> instead of creating a device.

Ack. I can do this, although I am nervous about this snowballing into a 
situation where I have a mega-module.

 > Please stop beating everything in a single module.

https://lore.kernel.org/all/250945d2-3940-9830-63e5-beec5f44010b@linaro.org/

Thanks,
Elliot
