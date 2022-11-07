Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163D3620109
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiKGVYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKGVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:24:09 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B7E85;
        Mon,  7 Nov 2022 13:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1667856218; bh=kyVFX8DDYqMyVifS8lF6+SU5qM2jk1LDK1egAj3BskM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WsJuYHXnAAwji21vsaeBwhhHPAQZL9fcQjEda6fut5/zBtaag588ULBe11yinskKi
         i5zuOvk/AHjHAS1JP2jA4vkqp+mCOsRBH+S4MzRFcVK0Q5v/KMhgPFnLe3ki9VDtuT
         jSpLkvNgzjeSgtbPi/ma3DcK3aRwAWJCHeEDeIURCqagoIePkEyNKHk9TAIDVQwr3i
         G+afV4nhEfOItztG6j9c1LcfZ+MCxO7rb8TZDmOekLLGCeLrLV+pIUHAeR1t40X4Cn
         aApVesXCC+XdhAwnImSnl7HQOTus9QB2BPWJK1MqGLIrNAWpF/cWOXom8tio6g5hI2
         mOxNzLN0yiJSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.104.14] ([141.76.182.128]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McY8T-1pQ7Md1XbR-00cv1U; Mon, 07
 Nov 2022 22:23:38 +0100
Subject: Re: [PATCH 1/2] platform/x86: dell-ddv: Improve buffer handling
To:     Hans de Goede <hdegoede@redhat.com>, david.e.box@linux.intel.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221102212336.380257-1-W_Armin@gmx.de>
 <fc480d25aabaa3923f24bbaa9b0f329f78c40abb.camel@linux.intel.com>
 <b84e5dfd-4908-ab85-469d-aed8af37ce91@redhat.com>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <83ddb667-d7f5-7f16-5e7e-3f2d92ce05e9@gmx.de>
Date:   Mon, 7 Nov 2022 22:23:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b84e5dfd-4908-ab85-469d-aed8af37ce91@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:dn9EW3NDF+opEStI03ZDpkA+VQIfj7g96ZIoMIqtmC71Grcgngf
 3+mOe1pi0s/FJ03CTmEAipaOj3UqqRKhRsg7dQByiCqJAAweykqlB23qvfuAoQsmINMkZYK
 DGEZECdF6DjEK8/6JkBKkYaOC7d2Q78zXp3Y9FNLm0znZjmn1yesVouRHhPOjIITG80Rh1j
 sdcy85LIvZCcxv49TDMng==
UI-OutboundReport: notjunk:1;M01:P0:d2mQzCmcsa4=;BiZAduBhbwtYBvhe+cNW8RP8/Kn
 GlgtN1ILen9T/JJCSZ0RAxEAiBkP1ioFxdZ7De1UsNmBQbkmTFhxxSu6iYif3MTZrUdvyYRB4
 kqnWAXb65fmDdHOGNoElp2+Xlvu+3aTAKXHX2lz1A5nUkX0jVXk4E4Cv2do9EEmEPOZTwljBZ
 cNpS7EehZyH+46c16+R2UlfcB8twzbFkM7R1mckWK4NXjOkJuoystXycDfe25E3YkKZwj3Q38
 9bZCYL4lw4A7UKLbS+O5h45Jomd3mdGfeODcEGZBBaB0cBT1dYadSp/CyWfnwVcQt6IrDTH1t
 9O/SL2Qt9FGEl4zzKnbiZ/EJZ9KR48dQ1zLbcb3xafQITGd/qdjdRdcwsHe30gb4ylGr+dptJ
 QvroiEHxfq9tRh9Ex49YfXerq66m0myi41TcOll+QO/tgw+Q9jljRlV62BuAcwX8UpTUEcZ2d
 LKeDLRGnysvk0VpUfU5eL4Yi0vKxlOiiVxhq2BUgy5m9KeR9C1AVaOO05V1a+JWTTk8E9QMi2
 vYtKwgsCGJbdPDLWq9EvCg9nxlpZcAQj5zkZx8m157IA4XqhznrWOS3evp2oobDjr9CWoEeMa
 GDfGg/aXs0cOHTTpDUurgXprGM4eSDQ/JjKRFTh2WKxhSXGaOM30qTx7r3Uma03PQmtGna/Qy
 NMTvl3Ty2YU0TV6syvuycWXaTHDJURHb/U1U7K61cdoKtcy3/DAWMowZG2fiIIzQpF/jM8kb6
 IS9/1o2xTyngRP32ppSvmjmEfu1mRV1W5nuEnFevMvRWfZJfGax9RGu6RaNyQ/qF2nAez8c0n
 VaIhqd51ZARjFsbrF7NkvYdH14BwkWNx5gHw8UUxj4WA2j5ylsLFfXIqns3+GNUQaXJGOlOaF
 suRipKQaSLlw541ZtWs6MkuXe9xkix1HwvB8QBB/3hncwj68xk7oQRVE9ns+u6Fhn9zD5Mc8L
 CuoJm4dIkAg0FrxJv959l9kgQ8Q=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.11.22 um 20:49 schrieb Hans de Goede:

> Hi,
>
> On 11/7/22 19:54, David E. Box wrote:
>> On Wed, 2022-11-02 at 22:23 +0100, Armin Wolf wrote:
>>> When the DDV interface returns a buffer, it actually
>>> returns a acpi buffer containing an integer (buffer size)
>>> and another acpi buffer (buffer content).
>>> The size of the buffer may be smaller than the size of
>>> the buffer content, which is perfectly valid and should not
>>> be treated as an error.
>> Is there documentation for this that you can refer to?

Yes and no. With the bmf2mof tool, i was able to extract the following MOF-description of the WMI interface:

[WMI, Dynamic, Provider("WmiProv"), Locale("MS\\0x409"), Description("WMI Function"), guid("{8A42EA14-4F2A-FD45-6422-0087F7A7E608}")]
class DDVWmiMethodFunction {
   [key, read] string InstanceName;
   [read] boolean Active;

   [WmiMethodId(1), Implemented, read, write, Description("Return Battery Design Capacity.")] void BatteryDesignCapacity([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(2), Implemented, read, write, Description("Return Battery Full Charge Capacity.")] void BatteryFullChargeCapacity([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(3), Implemented, read, write, Description("Return Battery Manufacture Name.")] void BatteryManufactureName([in] uint32 arg2, [out] string argr);
   [WmiMethodId(4), Implemented, read, write, Description("Return Battery Manufacture Date.")] void BatteryManufactureDate([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(5), Implemented, read, write, Description("Return Battery Serial Number.")] void BatterySerialNumber([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(6), Implemented, read, write, Description("Return Battery Chemistry Value.")] void BatteryChemistryValue([in] uint32 arg2, [out] string argr);
   [WmiMethodId(7), Implemented, read, write, Description("Return Battery Temperature.")] void BatteryTemperature([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(8), Implemented, read, write, Description("Return Battery Current.")] void BatteryCurrent([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(9), Implemented, read, write, Description("Return Battery Voltage.")] void BatteryVoltage([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(10), Implemented, read, write, Description("Return Battery Manufacture Access(MA code).")] void BatteryManufactureAceess([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(11), Implemented, read, write, Description("Return Battery Relative State-Of-Charge.")] void BatteryRelativeStateOfCharge([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(12), Implemented, read, write, Description("Return Battery Cycle Count")] void BatteryCycleCount([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(13), Implemented, read, write, Description("Return Battery ePPID")] void BatteryePPID([in] uint32 arg2, [out] string argr);
   [WmiMethodId(14), Implemented, read, write, Description("Return Battery Raw Analytics Start")] void BatteryeRawAnalyticsStart([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(15), Implemented, read, write, Description("Return Battery Raw Analytics")] void BatteryeRawAnalytics([in] uint32 arg2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
   [WmiMethodId(16), Implemented, read, write, Description("Return Battery Design Voltage.")] void BatteryDesignVoltage([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(18), Implemented, read, write, Description("Return Version.")] void ReturnVersion([in] uint32 arg2, [out] uint32 argr);
   [WmiMethodId(32), Implemented, read, write, Description("Return Fan Sensor Information")] void FanSensorInformation([in] uint32 arg2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
   [WmiMethodId(34), Implemented, read, write, Description("Return Thermal Sensor Information")] void ThermalSensorInformation([in] uint32 arg2, [out] uint32 RawSize, [out, WmiSizeIs("RawSize") : ToInstance] uint8 RawData[]);
};

I also found out that an "empty" fan sensor information buffer still has a content buffer length of 1, but a size integer
of 0.

>>> Also use the buffer size instead of the buffer content size
>>> when accessing the buffer to prevent accessing bogus data.
>>>
>>> Tested on a Dell Inspiron 3505.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>>   drivers/platform/x86/dell/dell-wmi-ddv.c | 12 +++++++-----
>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c
>>> b/drivers/platform/x86/dell/dell-wmi-ddv.c
>>> index 699feae3c435..1a001296e8c6 100644
>>> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
>>> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
>>> @@ -129,9 +129,9 @@ static int dell_wmi_ddv_query_buffer(struct wmi_device
>>> *wdev, enum dell_ddv_meth
>>>   	if (obj->package.elements[1].type != ACPI_TYPE_BUFFER)
>>>   		goto err_free;
>>>
>>> -	if (buffer_size != obj->package.elements[1].buffer.length) {
>>> +	if (buffer_size > obj->package.elements[1].buffer.length) {
>>>   		dev_warn(&wdev->dev,
>>> -			 FW_WARN "ACPI buffer size (%llu) does not match WMI
>>> buffer size (%d)\n",
>>> +			 FW_WARN "WMI buffer size (%llu) exceeds ACPI buffer
>>> size (%d)\n",
>>>   			 buffer_size, obj->package.elements[1].buffer.length);
>>>
>>>   		goto err_free;
>>> @@ -271,15 +271,17 @@ static int dell_wmi_ddv_buffer_read(struct seq_file
>>> *seq, enum dell_ddv_method m
>>>   	struct device *dev = seq->private;
>>>   	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
>>>   	union acpi_object *obj;
>>> -	union acpi_object buf;
>>> +	u64 size;
>>> +	u8 *buf;
>>>   	int ret;
>>>
>>>   	ret = dell_wmi_ddv_query_buffer(data->wdev, method, 0, &obj);
>>>   	if (ret < 0)
>>>   		return ret;
>>>
>>> -	buf = obj->package.elements[1];
>>> -	ret = seq_write(seq, buf.buffer.pointer, buf.buffer.length);
>>> +	size = obj->package.elements[0].integer.value;
>>> +	buf = obj->package.elements[1].buffer.pointer;
>>> +	ret = seq_write(seq, buf, size);
>> Okay, so the buffer may provide more space than what should actually be used
>> according to the size field. This looks like a bug that should have a fixes tag
>> on the original commit.
> I have already merged this and both the original commit as well as
> this fix will land in 6.2, so I don't think a Fixes commit is
> really necessary in this case.
>
> Also the old code checked that the 2 sizes matched, so it was more
> strict and as such running only the original patch should not lead
> to buffer overruns or anything like that.
>
> Regards,
>
> Hans
>
>
