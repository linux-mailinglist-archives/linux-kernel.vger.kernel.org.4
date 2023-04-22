Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABE06EB6EA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 04:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjDVCy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 22:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVCy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 22:54:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EFD2123;
        Fri, 21 Apr 2023 19:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=t7xpovDsoFsr+JoOWES8CRpdm1W02ysQAp56siLeCA4=; b=zZlZCU/uri+ahx2mt/eJosOTal
        M0gHvixbDcgzWdwdDKRN9SbCqjMOF//1Zm3Y/CaKGEF07SAf34QTdKxXF/1on2BkFNJ/HS5S6RNlA
        A8bU7SWnHOqDfnw/yD2N+JQNaFS7hpJvBDLls1eUeWB7qBllQTXINKtT7Bc2tPZIrQnoskEjb+e0u
        cRV8ujqbvgjHlHfjUsSnlBQTthbdE4xUeTMYflUgmobMHt0T6UVHBBwEEwsNNh9sBhY6asb1wMoZ5
        QVJl7xX/tkI017Tanmt8OUwOwGtqKfxTi3m4bgh9Ja1+X88ONfum5ztvvEt4uOpCbMBztVDG4u5RS
        PqzZ0z2Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pq3Ok-00CH1Z-1c;
        Sat, 22 Apr 2023 02:54:50 +0000
Message-ID: <5a8effb3-e176-5a2f-4650-17765384e60c@infradead.org>
Date:   Fri, 21 Apr 2023 19:54:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] platform/x86: wmi: Add kernel doc comments
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420233226.14561-1-W_Armin@gmx.de>
 <20230420233226.14561-2-W_Armin@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230420233226.14561-2-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/20/23 16:32, Armin Wolf wrote:
> Add kernel doc comments useful for documenting the functions/structs
> used to interact with the WMI driver core.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 51 +++++++++++++++++++++++++++++++-------
>  include/linux/wmi.h        | 41 +++++++++++++++++++++++++++---
>  2 files changed, 80 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index d81319a502ef..e4b41dca70c7 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -248,7 +248,9 @@ static acpi_status get_event_data(const struct wmi_block *wblock, struct acpi_bu
>   * @wdev: A wmi bus device from a driver
>   * @length: Required buffer size
>   *
> - * Allocates memory needed for buffer, stores the buffer size in that memory
> + * Allocates memory needed for buffer, stores the buffer size in that memory.
> + *
> + * Return: 0 on success or a negative error code for failure.
>   */
>  int set_required_buffer_size(struct wmi_device *wdev, u64 length)
>  {
> @@ -269,7 +271,9 @@ EXPORT_SYMBOL_GPL(set_required_buffer_size);
>   * @in: Buffer containing input for the method call
>   * @out: Empty buffer to return the method results
>   *
> - * Call an ACPI-WMI method
> + * Call an ACPI-WMI method, the caller must free @out.
> + *
> + * Return: acpi_status signaling success or error.
>   */
>  acpi_status wmi_evaluate_method(const char *guid_string, u8 instance, u32 method_id,
>  				const struct acpi_buffer *in, struct acpi_buffer *out)
> @@ -294,7 +298,9 @@ EXPORT_SYMBOL_GPL(wmi_evaluate_method);
>   * @in: Buffer containing input for the method call
>   * @out: Empty buffer to return the method results
>   *
> - * Call an ACPI-WMI method
> + * Call an ACPI-WMI method, the caller must free @out.
> + *
> + * Return: acpi_status signaling success or error.
>   */
>  acpi_status wmidev_evaluate_method(struct wmi_device *wdev, u8 instance, u32 method_id,
>  				   const struct acpi_buffer *in, struct acpi_buffer *out)
> @@ -411,7 +417,9 @@ static acpi_status __query_block(struct wmi_block *wblock, u8 instance,
>   * @instance: Instance index
>   * @out: Empty buffer to return the contents of the data block to
>   *
> - * Return the contents of an ACPI-WMI data block to a buffer
> + * Query a ACPI-WMI block, the caller must free @out.
> + *
> + * Return: ACPI object containing the content of the WMI block.
>   */
>  acpi_status wmi_query_block(const char *guid_string, u8 instance,
>  			    struct acpi_buffer *out)
> @@ -427,6 +435,15 @@ acpi_status wmi_query_block(const char *guid_string, u8 instance,
>  }
>  EXPORT_SYMBOL_GPL(wmi_query_block);
> 
> +/**
> + * wmidev_block_query - Return contents of a WMI block
> + * @wdev: A wmi bus device from a driver
> + * @instance: Instance index
> + *
> + * Query a ACPI-WMI block, the caller must free the result.

      Query an ACPI-WMI block,

> + *
> + * Return: ACPI object containing the content of the WMI block.
> + */
>  union acpi_object *wmidev_block_query(struct wmi_device *wdev, u8 instance)
>  {
>  	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -445,7 +462,9 @@ EXPORT_SYMBOL_GPL(wmidev_block_query);
>   * @instance: Instance index
>   * @in: Buffer containing new values for the data block
>   *
> - * Write the contents of the input buffer to an ACPI-WMI data block
> + * Write the contents of the input buffer to an ACPI-WMI data block.
> + *
> + * Return: acpi_status signaling success or error.
>   */
>  acpi_status wmi_set_block(const char *guid_string, u8 instance,
>  			  const struct acpi_buffer *in)
> @@ -555,6 +574,8 @@ static void wmi_notify_debug(u32 value, void *context)
>   * @data: Data to be returned to handler when event is fired
>   *
>   * Register a handler for events sent to the ACPI-WMI mapper device.
> + *
> + * Return: acpi_status signaling success or error.
>   */
>  acpi_status wmi_install_notify_handler(const char *guid,
>  				       wmi_notify_handler handler,
> @@ -597,6 +618,8 @@ EXPORT_SYMBOL_GPL(wmi_install_notify_handler);
>   * @guid: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>   *
>   * Unregister handler for events sent to the ACPI-WMI mapper device.
> + *
> + * Return: acpi_status signaling success or error.
>   */
>  acpi_status wmi_remove_notify_handler(const char *guid)
>  {
> @@ -641,9 +664,11 @@ EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);
>   * wmi_get_event_data - Get WMI data associated with an event
>   *
>   * @event: Event to find
> - * @out: Buffer to hold event data. out->pointer should be freed with kfree()
> + * @out: Buffer to hold event data
> + *
> + * Get extra data associated with an WMI event, the caller needs to free @out.
>   *
> - * Returns extra data associated with an event in WMI.
> + * Return: acpi_status signaling success or error.
>   */
>  acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
>  {
> @@ -664,7 +689,9 @@ EXPORT_SYMBOL_GPL(wmi_get_event_data);
>   * wmi_has_guid - Check if a GUID is available
>   * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
>   *
> - * Check if a given GUID is defined by _WDG
> + * Check if a given GUID is defined by _WDG.
> + *
> + * Return: True if GUID is available, false otherwise.
>   */
>  bool wmi_has_guid(const char *guid_string)
>  {
> @@ -678,7 +705,7 @@ EXPORT_SYMBOL_GPL(wmi_has_guid);
>   *
>   * Find the _UID of ACPI device associated with this WMI GUID.
>   *
> - * Return: The ACPI _UID field value or NULL if the WMI GUID was not found
> + * Return: The ACPI _UID field value or NULL if the WMI GUID was not found.
>   */
>  char *wmi_get_acpi_device_uid(const char *guid_string)
>  {
> @@ -1454,6 +1481,12 @@ int __must_check __wmi_driver_register(struct wmi_driver *driver,
>  }
>  EXPORT_SYMBOL(__wmi_driver_register);
> 
> +/**
> + * wmi_driver_unregister() - Unregister a WMI driver
> + * @driver: WMI driver to unregister
> + *
> + * Unregisters a WMI driver from the WMI bus.
> + */
>  void wmi_driver_unregister(struct wmi_driver *driver)
>  {
>  	driver_unregister(&driver->driver);
> diff --git a/include/linux/wmi.h b/include/linux/wmi.h
> index b88d7b58e61e..88f66b12eef9 100644
> --- a/include/linux/wmi.h
> +++ b/include/linux/wmi.h
> @@ -13,25 +13,44 @@
>  #include <linux/mod_devicetable.h>
>  #include <uapi/linux/wmi.h>
> 
> +/**
> + * struct wmi_device - WMI device structure
> + * @dev: Device associated with this WMI device
> + * @setable: True for devices implementing the Set Control Method

private: fields are not normally documented in kernel-doc.

> + *
> + * This represents WMI devices discovered by the WMI driver core.
> + */
>  struct wmi_device {
>  	struct device dev;
> 
> -	 /* True for data blocks implementing the Set Control Method */
> +	/* private: used by the WMI driver core */
>  	bool setable;
>  };
> 
> -/* evaluate the ACPI method associated with this device */
>  extern acpi_status wmidev_evaluate_method(struct wmi_device *wdev,
>  					  u8 instance, u32 method_id,
>  					  const struct acpi_buffer *in,
>  					  struct acpi_buffer *out);
> 
> -/* Caller must kfree the result. */
>  extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
>  					     u8 instance);
> 
>  extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);
> 
> +/**
> + * struct wmi_driver - WMI driver structure
> + * @driver: Driver model structure
> + * @id_table: List of WMI GUIDs supported by this driver
> + * @no_notify_data: WMI events provide no event data
> + * @probe: Callback for device binding
> + * @remove: Callback for device unbinding
> + * @notify: Callback for receiving WMI events
> + * @filter_callback: Callback for filtering device IOCTLs
> + *
> + * This represents WMI drivers which handle WMI devices.
> + * @filter_callback is only necessary for drivers which
> + * want to set up a WMI IOCTL interface.
> + */
>  struct wmi_driver {
>  	struct device_driver driver;
>  	const struct wmi_device_id *id_table;
> @@ -47,8 +66,24 @@ struct wmi_driver {
>  extern int __must_check __wmi_driver_register(struct wmi_driver *driver,
>  					      struct module *owner);
>  extern void wmi_driver_unregister(struct wmi_driver *driver);
> +
> +/**
> + * wmi_driver_register() - Helper macro ro register a WMI driver

s/ro/to/

> + * @driver: wmi_driver struct
> + *
> + * Helper macro for registering a WMI driver. It automatically passes
> + * THIS_MODULE to the underlying function.
> + */
>  #define wmi_driver_register(driver) __wmi_driver_register((driver), THIS_MODULE)
> 
> +/**
> + * module_wmi_driver() - Helper macro to register/unregister a WMI driver
> + * @__wmi_driver: wmi_driver struct
> + *
> + * Helper macro for WMI drivers which do not do anything special in module
> + * init/exit. This eliminates a lot of boilerplate. Each module may only
> + * use this macro once, and calling it replaces module_init() and module_exit().
> + */
>  #define module_wmi_driver(__wmi_driver) \
>  	module_driver(__wmi_driver, wmi_driver_register, \
>  		      wmi_driver_unregister)
> --

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.
-- 
~Randy
