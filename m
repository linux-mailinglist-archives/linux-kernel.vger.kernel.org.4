Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23756D947A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjDFKyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjDFKy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B2E55B3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680778421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pi28H7Ys3ragZ0WvGPlL8+NvRPjRFBU0lR+sJE70dXU=;
        b=VF7Fi54cVws/vAkLj1UDmYvSdzF1ub90SDK7/3RVN0uoW4q1u3B6MFvTejIc+wInYP+ld1
        FJ84bqqgpx7ZxYD5E+etYx8yBx2DvQW6QYQFf4ssXABLzZgsRbk+U2xlvS1HguPZFU6bFG
        rQ86c3XTj+rKvmakTCkOLjZ0B9FjGOc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-B_Fa_D0rMMuFbI4FO9khqw-1; Thu, 06 Apr 2023 06:53:40 -0400
X-MC-Unique: B_Fa_D0rMMuFbI4FO9khqw-1
Received: by mail-ej1-f69.google.com with SMTP id 22-20020a170906011600b0093d7f81fd04so56108eje.19
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 03:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680778418; x=1683370418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pi28H7Ys3ragZ0WvGPlL8+NvRPjRFBU0lR+sJE70dXU=;
        b=VMirnBkHxsl7Pxs78tCe23gOuKrM0Ug+ByXEzCnp29AavB/MI451EeMz8FcSq5ICVu
         GTTLb2SofnZa9Uk4Ua8DAWJYx+WtLmqra26i0gn8GdWQQuziSdDEWIGuHkvlPoGo/UaN
         yapJ2uXIIkyN4g9SwsmXzP6QrZ9dcUq4rnJ5xdn9XScDoLpcBgtjf+Qx+NV24McYrugD
         EMjwIaYSLq/sMx26rnpikVGZ4ylum3bOl1rnmkSebgvmOsGgtwfcdWrTS/JZiYdEQ2bv
         vcBepJJKyGUQAYHXy9FEZhQvNNi6Ox/qwtYGMP01F6EUxWu+6dfWtsAbklpVCIiS+0Fd
         s5AA==
X-Gm-Message-State: AAQBX9fZlY6JIz64G+n2nnYTsRbS+jmJYAfyfg/4C0yt4mCar175HmBi
        5jsFEjehPBvchVjzObsuSGdRxmA3buR82ahpDTTT5vA0mUamKqNEINf30Wiof3bSAEYl+10L+Xz
        QIK5wpmLQSadgQVaaHMKyT4ZTMJHmZwnU
X-Received: by 2002:a17:906:4d8c:b0:8b1:88aa:46da with SMTP id s12-20020a1709064d8c00b008b188aa46damr6227543eju.48.1680778418654;
        Thu, 06 Apr 2023 03:53:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZZfiP5eeuklEaQrdVVrA6BqszwkvZHtgP4NZZiG+OQJj261ImPta+swxAFCoNIv5pmoPKVJQ==
X-Received: by 2002:a17:906:4d8c:b0:8b1:88aa:46da with SMTP id s12-20020a1709064d8c00b008b188aa46damr6227525eju.48.1680778418309;
        Thu, 06 Apr 2023 03:53:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gs22-20020a170906f19600b00947d49ec819sm660247ejb.22.2023.04.06.03.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 03:53:37 -0700 (PDT)
Message-ID: <c5455226-1d51-1d3d-0b67-78a0473a9e8c@redhat.com>
Date:   Thu, 6 Apr 2023 12:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFCv3 1/1] platform/x86: Add virtual PMC driver used for S2Idle
Content-Language: en-US, nl
To:     Grzegorz Jaszczyk <jaz@semihalf.com>, linux-kernel@vger.kernel.org
Cc:     dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, seanjc@google.com,
        upstream@semihalf.com, markgross@kernel.org, dtor@google.com,
        mario.limonciello@amd.com, linux-pm@vger.kernel.org,
        x86@kernel.org, platform-driver-x86@vger.kernel.org,
        rafael@kernel.org
References: <20230213100921.268770-1-jaz@semihalf.com>
 <20230213100921.268770-2-jaz@semihalf.com>
 <CAH76GKOHMtwE7rLTPKUZJ_7xUUdHmHnGyZOsh8pFWoHCiWQynw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAH76GKOHMtwE7rLTPKUZJ_7xUUdHmHnGyZOsh8pFWoHCiWQynw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grzegorz,

On 3/29/23 14:33, Grzegorz Jaszczyk wrote:
> Hi Hans,
> 
> Do you think that this RFC is in good enough state to start the ACPI
> ID registration process so after it will be completed we could land
> this solution? Or maybe we could land it (of course if there are no
> other remarks) even before and adjust if needed?

I see from the links in the cover-letter that most of
the previous discussion has happened on the linux-pm list
and I believe that the linux-pm folks are in a better place
to answer this question then I am.

I have no objections against the suggested approach,
but I don't really feel that it is my call to make if
we should move forward with this.

Regards,

Hans



> pon., 13 lut 2023 o 11:11 Grzegorz Jaszczyk <jaz@semihalf.com> napisał(a):
>>
>> Virtual PMC driver is meant for the guest VMs for the S2Idle
>> notification. Its purpose is to register S2Idle dev ops check handler,
>> which will evaluate ACPI _DSM just before the guest enters S2Idle power
>> state.
>>
>> This allows to trap on MMIO access done as a consequence of _DSM
>> evaluation and therefore notify the VMM about the guest entering S2Idle
>> state.
>>
>> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
>> ---
>> Changelog v1..v2:
>> - Take advantage of acpi_s2idle_dev_ops's check() instead of notify()
>>
>> Changelog v2..v3:
>> - Add MODULE_LICENSE
>> - Remove "amd" prefixes
>> - Be more verbose in VIRT_PMC config description and make it
>>   HYPERVISOR_GUEST dependent
>> - Add extra check ensuring that DSM method supports ACPI_VIRT_PMC_NOTIFY function
>> ---
>>  drivers/platform/x86/Kconfig    |  7 +++
>>  drivers/platform/x86/Makefile   |  3 ++
>>  drivers/platform/x86/virt_pmc.c | 83 +++++++++++++++++++++++++++++++++
>>  3 files changed, 93 insertions(+)
>>  create mode 100644 drivers/platform/x86/virt_pmc.c
>>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 5692385e2d26..837ce201b68b 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -1099,6 +1099,13 @@ config WINMATE_FM07_KEYS
>>           buttons below the display. This module adds an input device
>>           that delivers key events when these buttons are pressed.
>>
>> +config VIRT_PMC
>> +       tristate "Virtual Power Management Controller"
>> +       depends on ACPI && SUSPEND && HYPERVISOR_GUEST
>> +       help
>> +         The Virtual PMC driver is meant for the guest VMs and its main
>> +         purpose is to notify about guest entering s2idle state.
>> +
>>  endif # X86_PLATFORM_DEVICES
>>
>>  config P2SB
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index 1d3d1b02541b..c4d3056cf4ea 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -129,6 +129,9 @@ obj-$(CONFIG_INTEL_SCU_WDT)         += intel_scu_wdt.o
>>  obj-$(CONFIG_INTEL_SCU_IPC_UTIL)       += intel_scu_ipcutil.o
>>  obj-$(CONFIG_X86_INTEL_LPSS)           += pmc_atom.o
>>
>> +# Virtual PMC
>> +obj-$(CONFIG_VIRT_PMC)                 += virt_pmc.o
>> +
>>  # Siemens Simatic Industrial PCs
>>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC)      += simatic-ipc.o
>>
>> diff --git a/drivers/platform/x86/virt_pmc.c b/drivers/platform/x86/virt_pmc.c
>> new file mode 100644
>> index 000000000000..a5966bb9048f
>> --- /dev/null
>> +++ b/drivers/platform/x86/virt_pmc.c
>> @@ -0,0 +1,83 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Virtual Power Management Controller Driver
>> + *
>> + * Author: Grzegorz Jaszczyk <jaz@semihalf.com>
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/platform_device.h>
>> +
>> +#define ACPI_VIRT_PMC_DSM_UUID "9ea49ba3-434a-49a6-be30-37cc55c4d397"
>> +#define ACPI_VIRT_PMC_NOTIFY 1
>> +
>> +static acpi_handle virt_pmc_handle;
>> +
>> +static void virt_pmc_s2idle_notify(void)
>> +{
>> +       union acpi_object *out_obj;
>> +       guid_t dsm_guid;
>> +
>> +       guid_parse(ACPI_VIRT_PMC_DSM_UUID, &dsm_guid);
>> +
>> +       out_obj = acpi_evaluate_dsm(virt_pmc_handle, &dsm_guid,
>> +                                       0, ACPI_VIRT_PMC_NOTIFY, NULL);
>> +
>> +       acpi_handle_debug(virt_pmc_handle, "_DSM function %u evaluation %s\n",
>> +                         ACPI_VIRT_PMC_NOTIFY, out_obj ? "successful" : "failed");
>> +
>> +       ACPI_FREE(out_obj);
>> +}
>> +
>> +static struct acpi_s2idle_dev_ops pmc_s2idle_dev_ops = {
>> +       .check = virt_pmc_s2idle_notify,
>> +};
>> +
>> +static int virt_pmc_probe(struct platform_device *pdev)
>> +{
>> +       int err = 0;
>> +       guid_t dsm_guid;
>> +
>> +       virt_pmc_handle = ACPI_HANDLE(&pdev->dev);
>> +
>> +       guid_parse(ACPI_VIRT_PMC_DSM_UUID, &dsm_guid);
>> +
>> +       if (!acpi_check_dsm(virt_pmc_handle, &dsm_guid, 0,
>> +                           1 << ACPI_VIRT_PMC_NOTIFY)) {
>> +               dev_err(&pdev->dev, "DSM method doesn't support ACPI_VIRT_PMC_NOTIFY\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       err = acpi_register_lps0_dev(&pmc_s2idle_dev_ops);
>> +       if (err)
>> +               dev_err(&pdev->dev, "failed to register LPS0 sleep handler\n");
>> +
>> +       return err;
>> +}
>> +
>> +static int virt_pmc_remove(struct platform_device *pdev)
>> +{
>> +       acpi_unregister_lps0_dev(&pmc_s2idle_dev_ops);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct acpi_device_id virt_pmc_acpi_ids[] = {
>> +       {"HYPE0001", 0}, /* _HID for XXX Power Engine, _CID PNP0D80*/
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(acpi, virt_pmc_acpi_ids);
>> +
>> +static struct platform_driver virt_pmc_driver = {
>> +       .driver = {
>> +               .name = "virtual_pmc",
>> +               .acpi_match_table = ACPI_PTR(virt_pmc_acpi_ids),
>> +       },
>> +       .probe = virt_pmc_probe,
>> +       .remove = virt_pmc_remove,
>> +};
>> +
>> +module_platform_driver(virt_pmc_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Virtual PMC Driver");
>> --
>> 2.39.1.581.gbfd45094c4-goog
>>
> 

