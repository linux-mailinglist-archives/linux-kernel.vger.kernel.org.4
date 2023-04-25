Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154776EE06C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjDYKe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjDYKe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DCCA3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682418849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7THULRhWgMcFebRgtK1WD8sev+RUBTaeAQwjg1I+VQ=;
        b=cnxKzhN5OSTfELkUDbpLeGh5ieVdw1fQhVCVqN1q5Sosg/EEbpBPQ/3jgL061XYvi5KNI9
        N2YGWuUn8XzrH0vcsozkDEtpLnotqrG/VFRMOFfpFO3EyaipZboFX3lldRGfyESr1LYpxs
        QOQ/JY3hfgfPMF3kAk60gftcrl90540=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-KfOidAoYMpqpGIFO0a8jzQ-1; Tue, 25 Apr 2023 06:34:08 -0400
X-MC-Unique: KfOidAoYMpqpGIFO0a8jzQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-505149e1a4eso14666093a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682418847; x=1685010847;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7THULRhWgMcFebRgtK1WD8sev+RUBTaeAQwjg1I+VQ=;
        b=Uf8thTz+3gdiM6BSVYAX29XByTP0VGaPpM/kxhqrveQzoRGRNO9Wvmyas3/QqJ4YPi
         6/D9YuK7k/dYQsW+CAA8NIH3aYlimfm3wro1BBzpxpAI7s18ocwPfkbYvz0ISFCc7zoF
         5r0ADFcuSbNSAzyzQTTJVF9AnPWC8KBRrxn3WjuoTyFeBasW6N2c9M2322UWZmPkAWah
         dwJicS99m8T82Cuou0Wn20Njbu+93C+LWWEVfnziLGMfabFIHGvcRMsUKtOBk5XnFGPQ
         vQpN/d7ftwqipqvwJ/MxUuHsqieCXB43q4qCKYBGPBzOEeuo0+jlJZIsE4vHn9nwlP5O
         J1wQ==
X-Gm-Message-State: AAQBX9coVFqN33XwXGO8glReimYAlhm6pgYjRBmFoLm3Eb5Pp1IZvqT9
        bGM6eofNxkpzJBmhR8bJi4EzfuD6h838jYHqfCyprqktd/88+UBA9LiB0ISACimB0DS5qtnLAZ1
        v9jpr1J/JiNTReXiZcYwcg7LX
X-Received: by 2002:a17:906:a007:b0:933:4d47:55b7 with SMTP id p7-20020a170906a00700b009334d4755b7mr13107371ejy.2.1682418847254;
        Tue, 25 Apr 2023 03:34:07 -0700 (PDT)
X-Google-Smtp-Source: AKy350YAYU/DR0ZaWkz5n4MShN6au3yfTGV9bLtppFGS3UL2Zj1HtySGTfbBLI84UGn9chQQMJ8A3g==
X-Received: by 2002:a17:906:a007:b0:933:4d47:55b7 with SMTP id p7-20020a170906a00700b009334d4755b7mr13107354ejy.2.1682418846891;
        Tue, 25 Apr 2023 03:34:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l7-20020a1709060e0700b0094ee21fe943sm6548204eji.116.2023.04.25.03.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 03:34:06 -0700 (PDT)
Message-ID: <6c05cc9e-815d-7a94-8b2d-f17fd5d47354@redhat.com>
Date:   Tue, 25 Apr 2023 12:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v10 03/14] HP BIOSCFG driver - bioscfg
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, Jorge Lopez <jorgealtxwork@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas@t-8ch.de
References: <20230419151321.6167-1-jorge.lopez2@hp.com>
 <20230419151321.6167-4-jorge.lopez2@hp.com>
 <38929a45-79de-964b-5d6f-cfa44099b35e@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <38929a45-79de-964b-5d6f-cfa44099b35e@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 4/19/23 20:04, Armin Wolf wrote:
> Am 19.04.23 um 17:13 schrieb Jorge Lopez:

<snip>

>> +static int __init bioscfg_init(void)
>> +{
>> +    int ret = 0;
>> +    int bios_capable = wmi_has_guid(HP_WMI_BIOS_GUID);
>> +
>> +    if (!bios_capable) {
>> +        pr_err("Unable to run on non-HP system\n");
>> +        return -ENODEV;
>> +    }
>> +
> 
> Currently, this driver will no get automatically loaded on supported hardware,
> something which would be quite beneficial for users to have.
> Since the HP_WMI_BIOS_GUID is already handled by the hp-wmi driver, maybe this
> driver (which also already implements a function similar to hp_wmi_perform_query())
> could register a platform device which is then used by this driver? This together
> with MODULE_DEVICE_TABLE() would allow for automatically loading the module on supported hardware.

Both drivers can already co-exist since the old hp-wmi driver uses the old
wmi kernel functions and is not a "wmi_driver" so there is no need for
a platform_device for this driver to bind to since the wmi_device is
still free for it to bind to.

This does indeed need a MODULE_DEVICE_TABLE() statement for
the bios_attr_pass_interface_id_table[] id-table. Note only for that
table, because the HP_WMI_BIOS_GUID is present on models which do
not support this and we don't want the module to auto-load there.

Regards,

Hans




> 
> Armin Wolf
> 
>> +    ret = init_bios_attr_set_interface();
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = init_bios_attr_pass_interface();
>> +    if (ret)
>> +        goto err_exit_bios_attr_set_interface;
>> +
>> +    if (!bioscfg_drv.bios_attr_wdev || !bioscfg_drv.password_attr_wdev) {
>> +        pr_debug("Failed to find set or pass interface\n");
>> +        ret = -ENODEV;
>> +        goto err_exit_bios_attr_pass_interface;
>> +    }
>> +
>> +    ret = fw_attributes_class_get(&fw_attr_class);
>> +    if (ret)
>> +        goto err_exit_bios_attr_pass_interface;
>> +
>> +    bioscfg_drv.class_dev = device_create(fw_attr_class, NULL, MKDEV(0, 0),
>> +                          NULL, "%s", DRIVER_NAME);
>> +    if (IS_ERR(bioscfg_drv.class_dev)) {
>> +        ret = PTR_ERR(bioscfg_drv.class_dev);
>> +        goto err_unregister_class;
>> +    }
>> +
>> +    bioscfg_drv.main_dir_kset = kset_create_and_add("attributes", NULL,
>> +                            &bioscfg_drv.class_dev->kobj);
>> +    if (!bioscfg_drv.main_dir_kset) {
>> +        ret = -ENOMEM;
>> +        pr_debug("Failed to create and add attributes\n");
>> +        goto err_destroy_classdev;
>> +    }
>> +
>> +    bioscfg_drv.authentication_dir_kset = kset_create_and_add("authentication", NULL,
>> +                                  &bioscfg_drv.class_dev->kobj);
>> +    if (!bioscfg_drv.authentication_dir_kset) {
>> +        ret = -ENOMEM;
>> +        pr_debug("Failed to create and add authentication\n");
>> +        goto err_release_attributes_data;
>> +    }
>> +
>> +    /*
>> +     * sysfs level attributes.
>> +     * - pending_reboot
>> +     */
>> +    ret = create_attributes_level_sysfs_files();
>> +    if (ret)
>> +        pr_debug("Failed to create sysfs level attributes\n");
>> +
>> +    ret = hp_init_bios_attributes(HPWMI_STRING_TYPE, HP_WMI_BIOS_STRING_GUID);
>> +    if (ret)
>> +        pr_debug("Failed to populate string type attributes\n");
>> +
>> +    ret = hp_init_bios_attributes(HPWMI_INTEGER_TYPE, HP_WMI_BIOS_INTEGER_GUID);
>> +    if (ret)
>> +        pr_debug("Failed to populate integer type attributes\n");
>> +
>> +    ret = hp_init_bios_attributes(HPWMI_ENUMERATION_TYPE, HP_WMI_BIOS_ENUMERATION_GUID);
>> +    if (ret)
>> +        pr_debug("Failed to populate enumeration type attributes\n");
>> +
>> +    ret = hp_init_bios_attributes(HPWMI_ORDERED_LIST_TYPE, HP_WMI_BIOS_ORDERED_LIST_GUID);
>> +    if (ret)
>> +        pr_debug("Failed to populate ordered list object type attributes\n");
>> +
>> +    ret = hp_init_bios_attributes(HPWMI_PASSWORD_TYPE, HP_WMI_BIOS_PASSWORD_GUID);
>> +    if (ret)
>> +        pr_debug("Failed to populate password object type attributes\n");
>> +
>> +    bioscfg_drv.spm_data.attr_name_kobj = NULL;
>> +    ret = hp_add_other_attributes(HPWMI_SECURE_PLATFORM_TYPE);
>> +    if (ret)
>> +        pr_debug("Failed to populate secure platform object type attribute\n");
>> +
>> +    bioscfg_drv.sure_start_attr_kobj = NULL;
>> +    ret = hp_add_other_attributes(HPWMI_SURE_START_TYPE);
>> +    if (ret)
>> +        pr_debug("Failed to populate sure start object type attribute\n");
>> +
>> +    return 0;
>> +
>> +err_release_attributes_data:
>> +    release_attributes_data();
>> +
>> +err_destroy_classdev:
>> +    device_destroy(fw_attr_class, MKDEV(0, 0));
>> +
>> +err_unregister_class:
>> +    fw_attributes_class_put();
>> +
>> +err_exit_bios_attr_pass_interface:
>> +    exit_bios_attr_pass_interface();
>> +
>> +err_exit_bios_attr_set_interface:
>> +    exit_bios_attr_set_interface();
>> +
>> +    return ret;
>> +}
>> +
>> +static void __exit bioscfg_exit(void)
>> +{
>> +    release_attributes_data();
>> +    device_destroy(fw_attr_class, MKDEV(0, 0));
>> +
>> +    fw_attributes_class_put();
>> +    exit_bios_attr_set_interface();
>> +    exit_bios_attr_pass_interface();
>> +}
>> +
>> +module_init(bioscfg_init);
>> +module_exit(bioscfg_exit);
> 

