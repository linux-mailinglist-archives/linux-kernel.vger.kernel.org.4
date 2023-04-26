Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A146EF346
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbjDZLUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240606AbjDZLUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:20:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 031265261;
        Wed, 26 Apr 2023 04:20:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 798E74B3;
        Wed, 26 Apr 2023 04:20:52 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FCA83F5A1;
        Wed, 26 Apr 2023 04:20:07 -0700 (PDT)
Date:   Wed, 26 Apr 2023 12:19:57 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "souvik.chakravarty@arm.com" <souvik.chakravarty@arm.com>
Subject: Re: [RFC v1 1/2] scmi: Introduce pinctrl SCMI protocol driver
Message-ID: <ZEkI3VeMN2vNBR3q@e120937-lin>
References: <cover.1680793130.git.oleksii_moisieiev@epam.com>
 <54119b2cb43e29f69c5858a5320d3a58f23fed21.1680793130.git.oleksii_moisieiev@epam.com>
 <ZDcqx9JVMvqr2WYu@e120937-lin>
 <71f48fcf-db04-b09f-2ab2-95e6562c8359@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71f48fcf-db04-b09f-2ab2-95e6562c8359@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 07:51:34PM +0000, Oleksii Moisieiev wrote:
>    Hi Cristian,
> 
>    On 13.04.23 01:04, Cristian Marussi wrote:
> 
> On Fri, Apr 07, 2023 at 10:18:27AM +0000, Oleksii Moisieiev wrote:
> 
> Implementation of the SCMI client driver, which implements
> PINCTRL_PROTOCOL. This protocol has ID 19 and is described
> in the latest DEN0056 document.
> 
> Hi,
> 

Hi Oleksii,

please do NOT post mail with html on the mailing list, it is very hard to
read and comment while useing text-only mail-reader (and not so much
appreciated :D) ; even readers with an UI can be setup to properly avoid
html stuff and properly format for Kernel upstream work:

https://www.kernel.org/doc/html/v4.10/process/email-clients.html

Indeed your original message now cannot even be found on lore, probably
discarded for the same reason ? (not sure).

My comments inline.

> 
> This protocol is part of the feature that was designed to
> separate the pinctrl subsystem from the SCP firmware.
> The idea is to separate communication of the pin control
> subsystem with the hardware to SCP firmware
> (or a similar system, such as ATF), which provides an interface
> to give the OS ability to control the hardware through SCMI protocol.
> This is a generic driver that implements SCMI protocol,
> independent of the platform type.
> 
> DEN0056 document:
> [1]https://urldefense.com/v3/__https://developer.arm.com/documentation/den0056/l
> atest__;!!GF_29dbcQIUBPA!wnEVmBR_V-0llnzQFsQfeZq5Ov7xJ87H364gqo1_UvsilzKNfJoy81u
> 5GR1f0EBIyXOGyesjURGdxT_U5tzLvqT5lgjNpw$ [developer[.]arm[.]com]
> 
> 
> No need to specify all of this in the commit message, just a note that
> you are adding a new SCMIv3.2 Pincontrol protocol, highlighting anything
> that has been left out in this patch (if any) will be enough.
> You can look at the very first commit logs of existing protos as an
> example like: drivers/firmware/arm_scmi/powercap.c
> 
> Some more comments down below, I'll mostly skip anything related to the
> SCMI API change I mentioned before...
> 
> I'll also wont comment on more trivial stuff related to style, BUT there
> are lots of them: you should run
> 
> ./scripts/checkpatch.pl --strict <your-git-format-patch-file>
> 
> for each patch in the series. (and fix accordingly..spacing, brackets...etc)
> 
>    Done.
> 
> +static int scmi_pinctrl_list_associations(const struct scmi_handle *handle,

[snip]

> +                                         u32 selector,
> +                                         enum scmi_pinctrl_selector_type type,
> +                                         uint16_t size, unsigned int *array)
> +{
> 
> This is the other functionalities you could implement straight away using
> ph->hops helpers (iterators) but just leave it this way, and I'll port it later
> (once we retested all of this as working with the new API but without any
> ph->hops usage..I think it is safer to change one bit at time... :P)
> 
>    Rewritten using iterators and checked with the unittests.

Good, thanks.

[snip]

> +static int scmi_pinctrl_get_group_info(const struct scmi_handle *handle,
> +                                      u32 selector,
> +                                      struct scmi_group_info *group)
> +{
> +       int ret = 0;
> +       struct scmi_pinctrl_info *pi;
> +
> +       if (!handle || !handle->pinctrl_priv || !group)
> +               return -EINVAL;
> +
> +       pi = handle->pinctrl_priv;
> +
> +       ret = scmi_pinctrl_attributes(handle, GROUP_TYPE, selector,
> +                                     &group->name,
> +                                     &group->nr_pins);
> +       if (ret)
> +               return ret;
> +
> +       if (!group->nr_pins) {
> +               dev_err(handle->dev, "Group %d has 0 elements", selector);
> +               return -ENODATA;
> +       }
> +
> +       group->group_pins = devm_kmalloc_array(handle->dev, group->nr_pins,
> +                                              sizeof(*group->group_pins),
> +                                              GFP_KERNEL);
> 
> I think you can just use for the array allocation
> 
>         devm_kcalloc(dev, n, size, flags)
> 
> and it will add also __GFP_ZERO internally to clear it.
> (indeed it calls in turn devm_kmalloc_array)
> 
> ...BUT I think there is a further tricky issue here related to memory allocation
> ...
> 
> You call this and others function of this kind from some scmi_pinctrl_ops,
> like in scmi_pinctrl_get_group_pins (scmi_pinctrl_ops->get_group_pins),
> and then this is in turn called by the SCMI Pinctrl driver via
> pinctrl_ops->get_group_pins AND you set a present flag so that you issue a
> PINCTRL_LIST_ASSOCIATIONS and allocate here a new group_pins array just
> the first time: but these are never released anywhere, since, even though
> lazily dynamically allocated when asked for, these are static data that
> you pass to the caller/user of this protocol and so you cannot release
> them anytime soon, indeed.
> 
> The core SCMI stack usually takes care to track and release all the devm_
> resources allocated by the protocol ONLY if they were allocated with devres
> while inside scmi_pinctrl_protocol_init() function.
> (see drivers/firmware/arm-scmi/driver.c:scmi_alloc_init_protocol_instance()
>  and scmi_protocol_release)
> 
> BUT you do not allocate these arrays inside the protocol-init function,
> you allocate them the first time these ops are called at runtime.
> 
> If you unbind/unload all the drivers using this protocol and then reload
> them, all the devm_ allocations in protocol_init will be freed and
> reallocated BUT these arrays will never be freed (they are boudn to handle->dev)
> and instead they will be reallocated multiple times (present flag will be cleare
> d
> on unload), remained unused and freed finally only when the whole SCMI stack is
> unbind/unloaded.
> 
> You use a present flag to avoid reissuing the same query and
> reallocating all the arrays each time a driver calls these
> protocol_ops one, but really all these data is available early on at
> protocol init time and they are not supposed to change at runtime, dont they ?
> 
> Even in a virtualized environment, you boot an agent and the SCMI
> platform server provides to the agent the list of associations when
> queried but then this does not change until the next reboot right ?
> (indeed you do not query more than once...)
> 
> The agent can only change the PIN status with CONFIG_SET or
> FUNCTION_SELECT or REQUEST the exclusive use of a pin/group, but it is
> not that the platform can change the pin/groups associaion for the same
> agent at run time, this are static data for the whole life of the agent.
> 
> Am I right ?
> 
> IOW I think there is some potential memory leak on unbind/bind and it would
> be better to query and allocate all of these resources at init time and keep
> them ready to be retrieved by subsequent operations, since the lifetime
> of these resources is pretty long and they are basically representing
> static data that does not change after the init/probe phases.
> 
> Indeed, all the other protocols usually allocate all the needed
> resources and query all the available SCMI resources once for all during
> the protocol_init, storing all the retrieved info in some struct *_info
> exposed in scmi_protocol.h and then provide some related protocol_ops to
> get the number of resources and to retrieve specific domain info descriptors.
> (voltage.c is an example and more on this down below...)
> 
> This way, any dynamic allocation is done during protocol_init, so
> it can be automatically freed by the SCMI core once there are no more
> users of that protocol, and all of this static info data is queried
> and retrieved once for all at protocol initialization time, avoiding
> unneeded message exchanges to retrieve always the same data.
> (which you avoid anyway with the present flag)
> 
> If you have a good reason to instead perform this sort of lazy
> allocation/query performed only at the last minute when someone ask for
> that specific resource, you will  have to provide also a .instance_deinit
> function to clean anything you allocated out of the .instance_init
> routine; but this would seem strange to me since any resource that is
> discovered at init will be eventually immediately queried by a driver
> which uses this protocol...am I missing something ?
> 
> 
>    This is a good point. But there is some reason why I've made such lazy
>    allocations:
> 
>    I agree that we have all data on the early stage, but we probably do
>    not want to request all associations.
> 
>    Let's assume we have partial pinctrl configuration with 2-3 groups, 2
>    functions and 10-15 pins involved.
> 
>    We don't want to request all 250 groups and 32 functions info during
>    init because this will impact boottime and memory consumption.

Yes I supposed this was the reason, and it could be reasonable to just
query the associations last minute when you need them for the stuff you
need which was put in the DT...I want to think a bit more about this,
being the only protocol that needs this behaviour. Good for now.

> 
>    Pinctrl subsystem will request all needed data during device-tree node
>    parsing.
> 
>    I have an idea to implement .instance_deinit callback from
>    scmi_protocol, which will cleanup all allocated data.
> 
>    What do you think about that? If it is ok for you - I'll push v2.
> 

I'd say do the cleanup with the available .instance_deinit as proposed
in the meantime, so we can see how all the changes and the update to
mainline kernel pans out...then we can discuss this further down the
line, maybe finding a better way to serve you lazy allocation from the
SCMI core (or not) and also see what Sudeep thinks abou these lazy
allocations.

[snip]

> + * struct scmi_pinctrl_ops - represents the various operations provided
> + * by SCMI Pinctrl Protocol
> + *
> + * @get_groups_count: returns count of the registered groups
> + * @get_group_name: returns group name by index
> + * @get_group_pins: returns the set of pins, assigned to the specified group
> + * @get_functions_count: returns count of the registered fucntions
> + * @get_function_name: returns function name by indes
> + * @get_function_groups: returns the set of groups, assigned to the specified
> + *     function
> + * @set_mux: set muxing function for groups of pins
> + * @get_pins: returns the set of pins, registered in driver
> + * @get_config: returns configuration parameter for pin
> + * @set_config: sets the configuration parameter for pin
> + * @get_config_group: returns the configuration parameter for a group of pins
> + * @set_config_group: sets the configuration parameter for a groups of pins
> + * @request_pin: aquire pin before selecting mux setting
> + * @free_pin: frees pin, acquired by request_pin call
> + */
> +struct scmi_pinctrl_ops {
> +       int (*get_groups_count)(const struct scmi_handle *handle);
> +       int (*get_group_name)(const struct scmi_handle *handles, u32 selector,
> +                             const char **name);
> +       int (*get_group_pins)(const struct scmi_handle *handle, u32 selector,
> +                             const unsigned int **pins, unsigned int *nr_pins);
> +       int (*get_functions_count)(const struct scmi_handle *handle);
> +       int (*get_function_name)(const struct scmi_handle *handle, u32 selector,
> +                                const char **name);
> +       int (*get_function_groups)(const struct scmi_handle *handle,
> +                                  u32 selector, unsigned int *nr_groups,
> +                                  const unsigned int **groups);
> +       int (*set_mux)(const struct scmi_handle *handle, u32 selector,
> +                      u32 group);
> +       int (*get_pin_name)(const struct scmi_handle *handle, u32 selector,
> +                           const char **name);
> +       int (*get_pins_count)(const struct scmi_handle *handle);
> +       int (*get_config)(const struct scmi_handle *handle, u32 pin,
> +                         u32 *config);
> +       int (*set_config)(const struct scmi_handle *handle, u32 pin,
> +                         u32 config);
> +       int (*get_config_group)(const struct scmi_handle *handle, u32 pin,
> +                         u32 *config);
> +       int (*set_config_group)(const struct scmi_handle *handle, u32 pin,
> +                         u32 config);
> +       int (*request_pin)(const struct scmi_handle *handle, u32 pin);
> +       int (*free_pin)(const struct scmi_handle *handle, u32 pin);
> +};
> +
> 
> As mentioned above, here you could drop a lot of this get_X_count/name/pins
> and instead expose a few of the internal proocol struct scmi__X_info and then
> provide just a mean to query how many resource are there and then get the info
> descriptor you want for the specific domain_id, i.e.:
> 
>     int (*num_domains_get)(ph, type)
>     void *(*info_get)(ph, type, domain_id);
> 
> Thanks,
> Cristian
> 
>    Updated. Exposed selector_type to scmi_protocol, which helped me to
>    reduce number of call.
> 
>    Looking forward for your thoughts about .instance_deinit callback
>    implementation I've mentioned above and I will be ready to push v2.
> 

As said, let'see V2 with cleanups in .instance_deinit and lazy
allocations as they are now and move on from there.

Thanks,
Cristian
