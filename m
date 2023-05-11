Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7586FEC00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbjEKGyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbjEKGxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:53:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C60E65A0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-3f315712406so271844295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683788020; x=1686380020;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UpvUNADgatGSUNbf1DFHHdQ9AqekXwHBfv8Q4aLvujc=;
        b=mBVlcxXH+iTZY0pBa0EAwoRxuLOBdwD03ZNhzjPDkkQKBC45w2SoM9+i/MvE5DS9kv
         eC6cpAvAsaO0nGVnY2MihTdzWfL18inltI32ZSNzoiTkxnNT//b3W17BG2TYV7AHmDHv
         JGa2gEC3ApeuGJL14csQYlXsPG0sCUweboabeMzoGXd2is7fAPDyK6WiTiJUHtRfOskj
         jG8laSAEtNvsDjXNpa5ZxrHVp7Pl14Fq5CbnloW3InnuKmgga6yhAavF4wXvibQEwAqQ
         CxLiWF+NKDey73x9cg148sA8ZtS8V7c/xSW3Y/o4hV+XphdBhQytPOd/c0G+e6MWs31V
         x7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788020; x=1686380020;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpvUNADgatGSUNbf1DFHHdQ9AqekXwHBfv8Q4aLvujc=;
        b=f7/gMV9BSPmtUIFIBYsRuolRr1XgzqfIm/df0GOkdGIchlZr/138VrcviFFM8rl7z4
         M50X9DwgPjnQ7uu0RW4Xph2vr0eSP4wRnUvPwza2cevQduvJK/SpieTLSliIwFdzG9gd
         EoKZABcJsDdsS6tUJjrrard68C/hgJ6ZTUAykHWt/fFCdA5/GPz49gYk+LyYPFG/41EN
         Oi2/473gLufF7nUYZNdEhQ7Nn0+1QavhJRbf8z5DuAP/0yK87FvQrmk4+bSGvVOufm4W
         M+fnVLP/hI6UQRy22r2THi6wc/mrZV4CwlWgXgQBU9UldOE+pW4/vc1ktukDidf4cYbo
         Pixg==
X-Gm-Message-State: AC+VfDw/GpYv+BaAGguRvSs1IsT0thqVD8azyQls6gLYhv6c0AeMC7yW
        ul4QUs7nIGS4+EUZEJ19NfpLqQ==
X-Google-Smtp-Source: ACHHUZ7dcPbLshCLrogTBjBWx+na9oz70eSVfMk2yYDxTzM4cwXzZAHRJRrzTrovFnsxBuxxRTnRWQ==
X-Received: by 2002:a05:600c:4e44:b0:3f4:9a86:f2ab with SMTP id e4-20020a05600c4e4400b003f49a86f2abmr2939240wmq.17.1683788019954;
        Wed, 10 May 2023 23:53:39 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:680a:d01:3110:8b33:cdf9:dea0])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bc8c8000000b003f4e8530696sm1038257wml.46.2023.05.10.23.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 23:53:39 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, acme@kernel.org, james.clark@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v6 6/6] Documentation: coresight: docs for config load via configfs
Date:   Thu, 11 May 2023 07:53:30 +0100
Message-Id: <20230511065330.26392-7-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511065330.26392-1-mike.leach@linaro.org>
References: <20230511065330.26392-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation covering the configfs updates that allow
configuration tables to be loaded and unloaded via configfs,
along with the demonstration programs in tools/coresight.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../trace/coresight/coresight-config.rst      | 265 ++++++++++++++++--
 1 file changed, 242 insertions(+), 23 deletions(-)

diff --git a/Documentation/trace/coresight/coresight-config.rst b/Documentation/trace/coresight/coresight-config.rst
index 6d5ffa6f7347..fe50bfaada5e 100644
--- a/Documentation/trace/coresight/coresight-config.rst
+++ b/Documentation/trace/coresight/coresight-config.rst
@@ -109,20 +109,20 @@ Operation
 
 The following steps take place in the operation of a configuration.
 
-1) In this example, the configuration is 'autofdo', which has an
-   associated feature 'strobing' that works on ETMv4 CoreSight Devices.
+1) In this example, the configuration is ``autofdo``, which has an
+   associated feature ``strobing`` that works on ETMv4 CoreSight Devices.
 
-2) The configuration is enabled. For example 'perf' may select the
+2) The configuration is enabled. For example ``perf`` may select the
    configuration as part of its command line::
 
     perf record -e cs_etm/autofdo/ myapp
 
-   which will enable the 'autofdo' configuration.
+   which will enable the ``autofdo`` configuration.
 
 3) perf starts tracing on the system. As each ETMv4 that perf uses for
    trace is enabled,  the configuration manager will check if the ETMv4
    has a feature that relates to the currently active configuration.
-   In this case 'strobing' is enabled & programmed into the ETMv4.
+   In this case ``strobing`` is enabled & programmed into the ETMv4.
 
 4) When the ETMv4 is disabled, any registers marked as needing to be
    saved will be read back.
@@ -136,18 +136,18 @@ Viewing Configurations and Features
 The set of configurations and features that are currently loaded into the
 system can be viewed using the configfs API.
 
-Mount configfs as normal and the 'cs-syscfg' subsystem will appear::
+Mount configfs as normal and the ``cs-syscfg`` subsystem will appear::
 
     $ ls /config
     cs-syscfg  stp-policy
 
-This has two sub-directories::
+This has two sub-directories, with the load and unload attribute files::
 
     $ cd cs-syscfg/
     $ ls
-    configurations  features
+    configurations features load  unload
 
-The system has the configuration 'autofdo' built in. It may be examined as
+The system has the configuration ``autofdo`` built in. It may be examined as
 follows::
 
     $ cd configurations/
@@ -162,7 +162,7 @@ follows::
     $ cat feature_refs
     strobing
 
-Each preset declared has a 'preset<n>' subdirectory declared. The values for
+Each preset declared has a ``preset<n>`` subdirectory declared. The values for
 the preset can be examined::
 
     $ cat preset1/values
@@ -170,7 +170,7 @@ the preset can be examined::
     $ cat preset2/values
     strobing.window = 0x1388 strobing.period = 0x4
 
-The 'enable' and 'preset' files allow the control of a configuration when
+The ``enable`` and ``preset`` files allow the control of a configuration when
 using CoreSight with sysfs.
 
 The features referenced by the configuration can be examined in the features
@@ -210,18 +210,18 @@ Using Configurations in perf
 ============================
 
 The configurations loaded into the CoreSight configuration management are
-also declared in the perf 'cs_etm' event infrastructure so that they can
+also declared in the perf ``cs_etm`` event infrastructure so that they can
 be selected when running trace under perf::
 
     $ ls /sys/devices/cs_etm
     cpu0  cpu2  events  nr_addr_filters		power  subsystem  uevent
     cpu1  cpu3  format  perf_event_mux_interval_ms	sinks  type
 
-The key directory here is 'events' - a generic perf directory which allows
+The key directory here is ``events`` - a generic perf directory which allows
 selection on the perf command line. As with the sinks entries, this provides
 a hash of the configuration name.
 
-The entry in the 'events' directory uses perfs built in syntax generator
+The entry in the ``events`` directory uses perfs built in syntax generator
 to substitute the syntax for the name when evaluating the command::
 
     $ ls events/
@@ -229,7 +229,7 @@ to substitute the syntax for the name when evaluating the command::
     $ cat events/autofdo
     configid=0xa7c3dddd
 
-The 'autofdo' configuration may be selected on the perf command line::
+The ``autofdo`` configuration may be selected on the perf command line::
 
     $ perf record -e cs_etm/autofdo/u --per-thread <application>
 
@@ -246,7 +246,7 @@ Using Configurations in sysfs
 Coresight can be controlled using sysfs. When this is in use then a configuration
 can be made active for the devices that are used in the sysfs session.
 
-In a configuration there are 'enable' and 'preset' files.
+In a configuration there are ``enable`` and ``preset`` files.
 
 To enable a configuration for use with sysfs::
 
@@ -256,13 +256,13 @@ To enable a configuration for use with sysfs::
 This will then use any default parameter values in the features - which can be
 adjusted as described above.
 
-To use a preset<n> set of parameter values::
+To use a ``preset<n>`` set of parameter values::
 
     $ echo 3 > preset
 
 This will select preset3 for the configuration.
 The valid values for preset are 0 - to deselect presets, and any value of
-<n> where a preset<n> sub-directory is present.
+<n> where a ``preset<n>`` sub-directory is present.
 
 Note that the active sysfs configuration is a global parameter, therefore
 only a single configuration can be active for sysfs at any one time.
@@ -278,9 +278,16 @@ Creating and Loading Custom Configurations
 ==========================================
 
 Custom configurations and / or features can be dynamically loaded into the
-system by using a loadable module.
+system by using a loadable module, or by loading a configuration table
+through in configfs.
 
-An example of a custom configuration is found in ./samples/coresight.
+Loaded configurations can use previously loaded features. The system will
+ensure that it is not possible to unload a feature that is currently in
+use, by enforcing the unload order as the strict reverse of the load order.
+
+
+Using a Loadable Module
+-----------------------
 
 This creates a new configuration that uses the existing built in
 strobing feature, but provides a different set of presets.
@@ -289,6 +296,218 @@ When the module is loaded, then the configuration appears in the configfs
 file system and is selectable in the same way as the built in configuration
 described above.
 
-Configurations can use previously loaded features. The system will ensure
-that it is not possible to unload a feature that is currently in use, by
-enforcing the unload order as the strict reverse of the load order.
+The file ``coresight-cfg-sample.c`` contains the configuration and module
+initialisation code needed to create the loadable module.
+
+This will be built alongside the kernel modules if selected in KConfig.
+(select ``CONFIG_SAMPLE_CORESIGHT_SYSCFG``).
+
+An example of a custom configuration module is found in ``./samples/coresight``.
+
+Using a Configuration Table File
+--------------------------------
+
+The ``./tools/coresight`` directory contains example programs to generate and
+read and print binary configuration table files.
+
+Building the tools creates the ``coresight-cfg-file-gen`` program that will
+generate a configuration binary ``example1.cscfg`` that can be loaded into the
+system using configfs. The configuration declared in the source file
+``coresight-cfg-example1.c`` is named ``autofdo3`` - the name that will be used
+once loaded.
+
+The source files ``coresight-cfg-bufw.h`` and ``coresight-cfg-bufw.c`` provide a
+standard function to convert a configuration declared in 'C' into the correct
+binary buffer format. These files can be re-used to create new custom
+configurations. Alternatively, additional examples can be added to the
+``coresight-cfg-file-gen`` program::
+
+    $ ./coresight-cfg-file-gen
+    Coresight Configuration file Generator
+
+    Generating example1 example
+    Generating example2 example
+
+The program ``coresight-cfg-file-read`` can read back and print a configuration
+binary. This is built using the file reader from the driver code
+(``coresight-config-file.c``), which is copied over into ``./tools/coresight`` at
+build time.::
+
+    ./coresight-cfg-file-read example1.cscfg
+    CoreSight Configuration file reader
+    ============================================
+
+    Configuration 1
+    Name:- autofdo3
+    Description:-
+    Setup ETMs with strobing for autofdo
+    Supplied presets allow experimentation with mark-space ratio for various loads
+
+    Uses 1 features:-
+    Feature-1: strobing
+
+    Provides 4 sets of preset values, 2 presets per set
+    set[0]: 0x7d0, 0x64,
+    set[1]: 0x7d0, 0x3e8,
+    set[2]: 0x7d0, 0x1388,
+    set[3]: 0x7d0, 0x2710,
+
+    ============================================
+    File contains no features
+
+There are additional attributes in the cs-syscfg directory - ``load`` and
+``unload`` that can be used to load and unload configuration tables.
+
+To load, 'cat' the table file into the load attribute::
+
+    $ ls /config/cs-syscfg
+    configurations features  load  show_last_load  unload
+    $ cat example1.cscfg > /config/cs-syscfg/load
+    $ ls /config/cs-syscfg/configurations/
+    autofdo  autofdo3
+
+As described above, in order to respect configuration dependencies, unload
+order is scrictly enforced to be the reverse of load order.
+
+``unload`` can be used to unload the last loaded configuration, but only
+if this was loaded using configfs.
+
+To unload, the *load name* of the configuration is written to ``unload``.
+This load name is the name of the first configuration in the table, or if no
+configurations, the name of the first feature.
+
+This name can be read either as described above, or by reading the
+``show_last_load`` attribute to obtain the details of the last loaded
+configuration::
+
+    $ cat /config/cs-syscfg/show_last_load
+    load name: autofdo3
+    load type: configfs dynamic load
+    (configurations:  autofdo3 )
+    (features:  None )
+
+Once this is known then unload by::
+
+    $ echo autofdo3 > /config/cs-syscfg/unload
+    ls /config/cs-syscfg/configurations/
+    autofdo
+
+Load and unload cannot be done if trace is in progress using a configuration.
+
+Unload will fail if the last loaded item was not a configfs dynamic loaded file.
+When using ``show_last_load`` a non configfs item will show::
+
+    cat /config/cs-syscfg/show_last_load
+    load name: [Not Set]
+    load type: Built in driver
+
+
+
+CoreSight Configuration Table Format
+------------------------------------
+
+The file format is defined in the source file ``coresight-config-table.h``
+
+The source reader and generator examples use/produce a table in this format,
+as a binary file.
+
+This arrangement is reproduced below:-
+
+Overall Table structure
+~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_table_header]  // Mandatory
+   [CONFIG_ELEM]*        // Optional - multiple, defined by cscfg_table_header.nr_configs
+   [FEATURE_ELEM]*       // Optional - multiple, defined by cscfg_table_header.nr_features
+
+Table is invalid if both [CONFIG_ELEM] and [FEATURE_ELEM] are omitted.
+
+A table that contains only [FEATURE_ELEM] may be loaded, and the features used
+by subsequently loaded files with [CONFIG_ELEM] elements.
+
+Element Name Strings
+~~~~~~~~~~~~~~~~~~~~
+
+Configuration name strings are required to consist of alphanumeric characters and '_' only. Other special characters are not permitted.
+
+For example ``my_config_2`` is a valid name, while ``this-bad-config#5`` will not work.
+
+This is in order to comply with the requirements of the perf command line.
+
+It is recommended that Feature and Parameter names use the same convention to allow for future enhancements to the command line syntax.
+
+CONFIG_ELEM element
+~~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_table_elem_header]               // header length value to end of feature strings.
+   [cscfg_table_elem_str]                  // name of the configuration.
+                                           // (see element string name requirements)
+   [cscfg_table_elem_str]                  // description of configuration.
+   [u16 value](nr_presets)                 // number of defined sets presets values.
+   [u32 value](nr_total_params)            // total parameters defined by all used features.
+   [u16 value](nr_feat_refs)               // number of features referenced by the configuration
+   [u64 values] * (nr_presets * nr_total_params)     // the preset values.
+   [cscfg_table_elem_str] * (nr_feat_refs) // names of features used in the configurations.
+
+FEATURE_ELEM element
+~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_table_elem_header]               // header length is total bytes to end of param structures.
+   [cscfg_table_elem_str]                  // feature name.
+   [cscfg_table_elem_str]                  // feature description.
+   [u32 value](match_flags)                // flags to associate the feature with a device.
+   [u16 value](nr_regs)                    // number of registers.
+   [u16 value](nr_params)                  // number of parameters.
+   [cscfg_regval_desc struct] * (nr_regs)  // register definitions
+   [PARAM_ELEM] * (nr_params)              // parameters definitions
+
+PARAM_ELEM element
+~~~~~~~~~~~~~~~~~~
+
+::
+
+   [cscfg_table_elem_str]        // parameter name.
+   [u64 value](param_value)      // initial value.
+
+Additional definitions
+~~~~~~~~~~~~~~~~~~~~~~
+
+The following structures are defined in ``coresight-config-file.h``
+
+ * ``struct cscfg_table_header`` : This structure contains an initial magic number, the total
+   length of the table, and the number of configurations and features in the table.
+ * ``struct cscfg_table_elem_header``: This defines the total length and type of a CONFIG_ELEM
+   or a FEATURE_ELEM.
+ * ``struct cscfg_table_elem_str``: This defines a string and its length.
+
+The magic number in cscfg_table_header is defined as two bitfields::
+
+   [31:8] Fixed magic number to identify table type.
+   [7:0]  Current table format version.
+
+The following defines determine the maximum overall table size and maximum individual
+string size
+
+ * ``CSCFG_TABLE_MAXSIZE``      : maximum overall table size.
+ * ``CSCFG_TABLE_STR_MAXSIZE``  : maximum individual string size.
+
+Load Dependencies
+~~~~~~~~~~~~~~~~~
+
+Files may be unloaded only in the strict reverse order of loading. This is enforced by the
+configuration system.
+
+This is to ensure that any load dependencies are maintained.
+
+A configuration table that contains a CONFIG_ELEM that references named features "feat_A" and "feat_B" will load only if either:-
+
+a) "feat_A" and/or "feat_B" has been loaded previously, or are present as built-in / module loaded features.
+b) "feat_A" and/or "feat_B" are declared as FEAT_ELEM in the same table as the CONFIG_ELEM.
+
+Tables that contain features or configurations with the same names as those already loaded will fail to load.
-- 
2.17.1

