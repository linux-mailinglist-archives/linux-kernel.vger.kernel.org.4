Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F258F6A4D87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjB0VrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjB0Vq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:46:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA061F909;
        Mon, 27 Feb 2023 13:46:57 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RLIGAr020104;
        Mon, 27 Feb 2023 21:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RMY240oahL23plEikFUklqVHDD5xMLS3GDtXfnEQWn4=;
 b=jW7BqaCOg/npZmYBkXsBBpVhRWttBo9JBUz7GevpfbU4yuZ0oSA1IEvLz7sh9nfYWp2A
 CxPcJRoXhu0D35gJDNsDbA1UovgtZPrqDwhHr3AqJMGh6MXOiCEa//8WP47sWjrBelbR
 pKnaXlmjFz4xOUmH3xwvLjdDWbgxjft+Pe5EDdaF99sD0clNfboNnj7NikRxm0bHmMac
 6R48AuTKnDRzTxFq4ND0xJa2hxnVvxQD13EW5VgIPMgO4L/ggSB7qpIpXE0JJluhU7DO
 Y59jHkya9CqHTf77VgRISGHTaL94sFb+oC23qI8fCPMoj64EIj5M5zm6mNgSo8mtsMX4 bg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ny81qeewy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 21:46:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31RLkqkk020784
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 21:46:52 GMT
Received: from [10.47.233.232] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Feb
 2023 13:46:52 -0800
Subject: Re: [RESEND 1/2] power_supply: Register cooling device outside of
 probe
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Manaf Meethalavalappu Pallikunhi" <quic_manafm@quicinc.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@google.com>
References: <20220531183054.6476-1-quic_manafm@quicinc.com>
 <20220609221224.t5k7i4w4dfjza5xc@mercury.elektranox.org>
From:   Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Message-ID: <fd372789-d39e-08f9-ae44-7702733155ae@quicinc.com>
Date:   Mon, 27 Feb 2023 13:46:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220609221224.t5k7i4w4dfjza5xc@mercury.elektranox.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WXwdnArxN6GZC1yqrHdrenMEFOj_TfR4
X-Proofpoint-GUID: WXwdnArxN6GZC1yqrHdrenMEFOj_TfR4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_17,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270173
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 3:12 PM, Sebastian Reichel wrote:
> Hi,
>
> On Wed, Jun 01, 2022 at 12:00:53AM +0530, Manaf Meethalavalappu Pallikunhi wrote:
>> Registering the cooling device from the probe can result in the
>> execution of get_property() function before it gets initialized.
>>
>> To avoid this, register the cooling device from a workqueue
>> instead of registering in the probe.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
>> ---
> This removes error handling from the psy_register_cooler() call, so
> it introduces a new potential problem. If power_supply_get_property()
> is called to early -EAGAIN is returned. So can you elaborate the problem
> that you are seeing with the current code?
>
> -- Sebastian

When the device boots up with all the vendor modules getting loaded,           
here is what we're seeing when booting up with 6.1.11 recently. First          
log is printed with adding a pr_err() in __power_supply_register().                 
                                                                               
[    7.008938][  T682] power_supply battery: psy_register_cooler failed, rc=-11
[    7.030941][  T682] qti_battery_charger: probe of qcom,battery_charger failed with error -11
                                                                               
Here, our downstream qti_battery_charger driver exposes the following          
power supply properties POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT and             
POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX under a power supply device.        
                                                                               
This is happening because of the following call sequence,                      
                                                                               
battery_chg_probe() ->                                                         
  power_supply_register() ->                                                   
    psy_register_cooler() ->                                                   
      thermal_cooling_device_register() ->                                     
        cdev->ops->get_max_state() ->                                          
          ps_get_max_charge_cntl_limit() ->                                    
            power_supply_get_property()                                        
                                                                               
ends up calling power_supply_get_property() to read CHARGE_CONTROL_LIMIT       
property.                                                                      
                                                                               
However, it returns -EAGAIN because psy->initialized is set to true            
later after psy_register_cooler() succeeds. So, this ends up in a              
driver probe failure forever.

-Subbaraman
>
>>  drivers/power/supply/power_supply_core.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
>> index 385814a14a0a..74623c4977db 100644
>> --- a/drivers/power/supply/power_supply_core.c
>> +++ b/drivers/power/supply/power_supply_core.c
>> @@ -132,6 +132,7 @@ void power_supply_changed(struct power_supply *psy)
>>  }
>>  EXPORT_SYMBOL_GPL(power_supply_changed);
>>  
>> +static int psy_register_cooler(struct power_supply *psy);
>>  /*
>>   * Notify that power supply was registered after parent finished the probing.
>>   *
>> @@ -139,6 +140,8 @@ EXPORT_SYMBOL_GPL(power_supply_changed);
>>   * calling power_supply_changed() directly from power_supply_register()
>>   * would lead to execution of get_property() function provided by the driver
>>   * too early - before the probe ends.
>> + * Also, registering cooling device from the probe will execute the
>> + * get_property() function. So register the cooling device after the probe.
>>   *
>>   * Avoid that by waiting on parent's mutex.
>>   */
>> @@ -156,6 +159,7 @@ static void power_supply_deferred_register_work(struct work_struct *work)
>>  	}
>>  
>>  	power_supply_changed(psy);
>> +	psy_register_cooler(psy);
>>  
>>  	if (psy->dev.parent)
>>  		mutex_unlock(&psy->dev.parent->mutex);
>> @@ -1261,10 +1265,6 @@ __power_supply_register(struct device *parent,
>>  	if (rc)
>>  		goto register_thermal_failed;
>>  
>> -	rc = psy_register_cooler(psy);
>> -	if (rc)
>> -		goto register_cooler_failed;
>> -
>>  	rc = power_supply_create_triggers(psy);
>>  	if (rc)
>>  		goto create_triggers_failed;
>> @@ -1294,8 +1294,6 @@ __power_supply_register(struct device *parent,
>>  add_hwmon_sysfs_failed:
>>  	power_supply_remove_triggers(psy);
>>  create_triggers_failed:
>> -	psy_unregister_cooler(psy);
>> -register_cooler_failed:
>>  	psy_unregister_thermal(psy);
>>  register_thermal_failed:
>>  	device_del(dev);

