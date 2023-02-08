Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C9D68EE3F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjBHLth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBHLtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:49:12 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38094671E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 03:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675856951; x=1707392951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m/QL/KPvFqvZVyIoVdhnN/Zk6YBWSO0qjMpEA4pC0ZU=;
  b=bMV/hcAIuyor9fJEv8f5eSW+3z28rR6jsbhT6aGXI98TUjlezWERU7X5
   iFliUCuTu6cdtk2XoFxsEk/xmFRRztnHkLgD1KBG1h7R1quzuhdHSSzDJ
   zEO1iZYQ8+ntq+SckwGNxipFUDyKqwHser1A+On4O//nVD9jA8/KkS7V8
   QXCjid/U3HSjjg3MSZkQwCvo9tA8zJ616JCjVGOiXfDBCB7Ut6ULlrVGJ
   eXYZh/D8eN3eNWNHbQ6EN/8JYSbW84Hh3w3lM81zF7vfcSojq4BkqBldi
   j86RDSSuJQo+w9MWAxlxPbYSnWqGyZ32114bqPvHoz3/Z9zKRVJRqGDx7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="310126502"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="310126502"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 03:48:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="912704738"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="912704738"
Received: from rajatkha-mobl.gar.corp.intel.com (HELO [10.213.112.83]) ([10.213.112.83])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 03:48:49 -0800
Message-ID: <cb6dae61-e932-5690-e21f-b0ab0df66462@linux.intel.com>
Date:   Wed, 8 Feb 2023 17:18:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] platform/chrome: Avoid fetching the type-C parameters
 again
Content-Language: en-US
To:     Prashant Malani <pmalani@chromium.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com, abhijeet.rao@intel.com
References: <20230207073610.3290391-1-rajat.khandelwal@linux.intel.com>
 <CACeCKad1suBNrpPOtKnHaLZmLEpgV4ExA53ermqv50viSSnLdA@mail.gmail.com>
 <d3254107-406e-6eff-6305-51405ab09e08@linux.intel.com>
 <CACeCKaeNaeaDvotPvWyk27Hv-2O5ebqkndkSgpCUUTaCvnNaEA@mail.gmail.com>
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
In-Reply-To: <CACeCKaeNaeaDvotPvWyk27Hv-2O5ebqkndkSgpCUUTaCvnNaEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

I think I got it now. Ultimately, the 'device' mux_dev has to be ref-incremented
for another driver (in our case - cros-ec-typec).
Was in confusion if that'd be necessary since one of the type-C drivers - ANX7411
registers the 'typec_port' inside its struct by 'typec_register_port', and uses the
'typec_mux' from within the struct rather than ref-incrementing it again.
To be more specific,
	return typec_set_mode(ctx->typec.port, mode);
//Here the port corresponds to 'typec_port' and ultimately it will use 'typec_mux' from
//it and call 'typec_mux_set'.

Maybe something else could be going on here, or I missed something? Not sure.

Ok, raw assigning the pointers is not the solution, I agree. How about something like this?

static void cros_typec_params_get(struct cros_typec_port *cros_port)
{
         struct typec_port *port = cros_port->port;
         struct typec_switch_dev *sw_dev;
         struct typec_mux_dev *mux_dev;

	if (IS_ERR_OR_NULL(port))
		return;

         cros_port->mux = port->mux;
	mux_dev = cros_port->mux->mux_dev;
         get_device(&mux_dev->dev);

         cros_port->ori_sw = port->sw;
	sw_dev = cros_port->ori_sw->sw_dev;
         get_device(&sw_dev->dev);
}
  
This will increment the ref-count of the device nodes (pardon me, if any compilation error :)).

All I am pushing for is to not go through fwnode_match again and find the same mux_dev/sw_dev.
If ref-count has to be incremented, we can do it like above.

Should this not be a more robust way we assign the device nodes to our cros-ec-typec port node,
which we have already populated?

Thanks
Rajat

On 2/8/2023 12:06 AM, Prashant Malani wrote:
> Hey Rajat,
>
> On Tue, Feb 7, 2023 at 12:53 AM Rajat Khandelwal
> <rajat.khandelwal@linux.intel.com> wrote:
>> Hi Prashant,
>> Please find the comments inline.
>>
>> On 2/7/2023 1:25 AM, Prashant Malani wrote:
>>
>> Hi Rajat,
>>
>> Please use the right header in the commit message. There are plenty of
>> examples in the git log.
>>
>> Got it Prashant.
>>
>> On Sun, Feb 5, 2023 at 11:34 PM Rajat Khandelwal
>> <rajat.khandelwal@linux.intel.com> wrote:
>>
>> The struct 'cros_typec_port' incorporates three type-C parameters,
>> 'ori_sw', 'retimer', and 'mux'.
>> These parameters in the struct 'typec_port' are being already
>> configured when 'typec_register_port' is being called.
>>
>> The bigger picture - 'typec_register_port' can return an error and
>> the type-C parameters could go unconfigured. However, the callback
>> will return EPROBE_DEFER and the driver will again be getting probed
>> trying to configure them again.
>> However, currently, they are again tried to get fetched for the
>> 'cros_typec_port' struct, which sometimes could result in an error
>> and these parameters could go unconfigured (no provision of deferring
>> the probe in this case, so we are left with unconfigured parameters).
>>
>> This is by design. If the switch handles cannot be obtained for any reason
>> other that -EPROBE_DEFER, we will not re-attempt to acquire them, and
>> should continue driver probe and carry on with limited functionality.
>>
>> Why should we even try to acquire them in cros-ec-typec, when we can use them
>> natively populated?
> Those handles are internal to the Type-C class code. Anything outside shouldn't
> be accessing them (that applies to anything within struct typec_port); they are
> intentionally kept opaque to protect implementation internals.
>
>> If there is a sporadic error other than -EPROBE_DEFER, that points to a
>> deeper issue in firmware which should be investigated.
>>
>> Hence, assign the parameters to the corresponding ones in the struct
>> 'typec_port' after they are fetched in 'typec_register_port'.
>>
>> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
>> ---
>>   drivers/platform/chrome/cros_ec_typec.c | 58 ++++++++++---------------
>>   1 file changed, 22 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
>> index 001b0de95a46..0265c0d38bd6 100644
>> --- a/drivers/platform/chrome/cros_ec_typec.c
>> +++ b/drivers/platform/chrome/cros_ec_typec.c
>> @@ -24,6 +24,8 @@
>>   #include <linux/usb/typec_tbt.h>
>>   #include <linux/usb/role.h>
>>
>> +#include "../../usb/typec/class.h"
>>
>> That is a local header. We cannot use it outside of drivers/usb/typec/
>>
>> Ok, sure. To avoid restructuring the struct definitions, I simply put it for now.
>> This can be rectified after we arrive at a culmination.
>>
>> +
>>   #define DRV_NAME "cros-ec-typec"
>>
>>   #define DP_PORT_VDO    (DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
>> @@ -141,47 +143,17 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
>>          return 0;
>>   }
>>
>> -static int cros_typec_get_switch_handles(struct cros_typec_port *port,
>> -                                        struct fwnode_handle *fwnode,
>> -                                        struct device *dev)
>> +static int cros_typec_get_role_switch_handle(struct cros_typec_port *port,
>> +                                            struct fwnode_handle *fwnode,
>> +                                            struct device *dev)
>>   {
>> -       port->mux = fwnode_typec_mux_get(fwnode, NULL);
>> -       if (IS_ERR(port->mux)) {
>> -               dev_dbg(dev, "Mux handle not found.\n");
>> -               goto mux_err;
>> -       }
>> -
>> -       port->retimer = fwnode_typec_retimer_get(fwnode);
>> -       if (IS_ERR(port->retimer)) {
>> -               dev_dbg(dev, "Retimer handle not found.\n");
>> -               goto retimer_sw_err;
>> -       }
>> -
>> -       port->ori_sw = fwnode_typec_switch_get(fwnode);
>> -       if (IS_ERR(port->ori_sw)) {
>> -               dev_dbg(dev, "Orientation switch handle not found.\n");
>> -               goto ori_sw_err;
>> -       }
>> -
>>          port->role_sw = fwnode_usb_role_switch_get(fwnode);
>>          if (IS_ERR(port->role_sw)) {
>>                  dev_dbg(dev, "USB role switch handle not found.\n");
>> -               goto role_sw_err;
>> +               return -ENODEV;
>>          }
>>
>>          return 0;
>> -
>> -role_sw_err:
>> -       typec_switch_put(port->ori_sw);
>> -       port->ori_sw = NULL;
>> -ori_sw_err:
>> -       typec_retimer_put(port->retimer);
>> -       port->retimer = NULL;
>> -retimer_sw_err:
>> -       typec_mux_put(port->mux);
>> -       port->mux = NULL;
>> -mux_err:
>> -       return -ENODEV;
>>   }
>>
>>   static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
>> @@ -363,6 +335,18 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
>>          return 0;
>>   }
>>
>> +static void cros_typec_copy_port_params(struct cros_typec_port *cros_port)
>> +{
>> +       struct typec_port *port = cros_port->port;
>> +
>> +       if (IS_ERR_OR_NULL(port))
>> +               return;
>> +
>> +       cros_port->mux = port->mux;
>> +       cros_port->retimer = port->retimer;
>> +       cros_port->ori_sw = port->sw;
>> +}
>>
>> Sorry, but this is not the right approach. These handles are
>> ref-counted. We intentionally
>> take extra references to these using the provided API. Please don't
>> use raw references like this.
>>
>> Aah, didn't see they were getting ref-counted. Even so, I don't understand
>> the part that why do we need to take extra references? Can't we not use the
>> same reference to the nodes which were populated in the type-C driver?
> No; they have to be refcounted (that's the way all firmware node handles
> are used). Any "client" or "caller" that wants to use the fwnode handles
> has to use the correct APIs. Refcounting is necessary for the fwnode/property
> framework to ensure that there are no stale references for firmware device
> nodes (needed to prevent leaks during device creation/removal). If the fwnode
> framework doesn't know that you (driver) have a reference, it is free
> to invalidate
> that reference (and remove the underlying device) without you(driver)
> knowing anything about it (I'm sure I'm oversimplifying a lot over
> here, but that
> is the gist AFAIK).
>
>> On another note, maybe remove these 3 handles from 'cros_typec_port' altogether,
>> and use the handles from 'typec_port' inside the 'cros_typec_struct'?
>> Other drivers
>> in the type-C domain use the same concept AFAIK. They just have the 'typec_port' from
>> which they use all the handles natively populated.
> What drivers are these? No port driver should be using these handles without
> refcounting them with the right API calls.
>
>> Further, the same 'fwnode' will be matched in 'typec_mux_match'/'typec_switch_match',
>> irrespective of it being called from 'typec_register_port' or 'cros_typec_get_switch_handles'.
>> Thus, mux->mux_dev->dev and sw->sw_dev->dev will represent the same 'dev' struct.
>> Is there actually a point of referencing them again in cros-ec-typec? Even when we decrement the
>> ref-counter, it will be decremented of the same 'dev'!
>> Please correct me if I'm wrong. :)
>>
>> Also, if the fwnode_*_get() functions are failing, why are we to
>> assume that they worked for the
>> Type-C class code (that code uses the same functions) [1] ?
>>
>> They surely worked for the type-C class code, since if either of the 'mux' and 'switch'
>> handles are ERR, it will return an error. cros-ec-typec will then try to probe again.
>> Since the handling reaches after the 'typec_register_port', I think we can be sure that they
>> had to be succeeded for the type-C class driver.
> If those calls are succeeding when they are called within typec_register_port(),
> there is no reason why they should fail when called from cros-ec-typec (we
> are just taking references to existing handles after all).
> I would suggest looking into why the calls to get the firmware handles
> are failing
> from the port driver.
>
>
> On a unrelated note: Are you responding in plain text mode? I suspect
> you may not be,
> since the indentation of responses is getting messed up.
>
> BR,
>
> -Prashant
